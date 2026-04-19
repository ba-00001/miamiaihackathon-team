from flask import Blueprint, request, jsonify
from services.modelslab import ModelslabService
from services.s3_service import S3Service
from models.generation import Generation
from extensions import db
import json
import traceback

api_bp = Blueprint('api', __name__)
modelslab_service = ModelslabService()
s3_service = S3Service()


# ─── HEALTH ────────────────────────────────────────────────
@api_bp.route('/api/health', methods=['GET'])
def health():
    return jsonify({"status": "ok"})


# ─── FILE UPLOAD → S3 public URL ──────────────────────────
@api_bp.route('/api/upload', methods=['POST'])
def upload_media():
    """Accept a file upload OR a JSON { "url": "..." }.
    Returns a PUBLIC S3 URL that Modelslab can directly access."""

    # Option A: multipart file upload
    if 'file' in request.files:
        f = request.files['file']
        content_type = f.content_type or 'application/octet-stream'
        s3_key = s3_service.upload_file(f.stream, f.filename, content_type)
        public_url = s3_service.get_public_url(s3_key)
        return jsonify({
            "s3_key": s3_key,
            "public_url": public_url,       # direct URL for Modelslab
            "presigned_url": public_url,     # keep compat with frontend
        })

    # Option B: JSON with a URL to re-host
    data = request.get_json(silent=True)
    if data and data.get('url'):
        s3_key = s3_service.upload_url_public(data['url'])
        public_url = s3_service.get_public_url(s3_key)
        return jsonify({
            "s3_key": s3_key,
            "public_url": public_url,
            "presigned_url": public_url,
        })

    return jsonify({"error": "Provide a file or a JSON { \"url\": \"...\" }"}), 400


# ─── SEEDANCE (start/end frame → video) ───────────────────
@api_bp.route('/api/seedance', methods=['POST'])
def generate_seedance():
    data = request.get_json()
    if not data:
        return jsonify({"error": "Missing JSON body"}), 400

    try:
        # Build the Modelslab-compatible payload
        payload = {}

        payload["prompt"] = data.get("prompt", "")

        # Images — must be publicly accessible URLs
        if data.get("init_image"):
            payload["init_image"] = data["init_image"]
        if data.get("end_image"):
            payload["end_image"] = data["end_image"]

        # Seedance 2.0 API parameters
        if data.get("aspect_ratio"):
            payload["aspect_ratio"] = data["aspect_ratio"]
        if data.get("resolution"):
            payload["resolution"] = data["resolution"]
            
        if data.get("duration"):
            # Enforce Integer
            try:
                payload["duration"] = int(str(data["duration"]).replace("sec", "").strip())
            except ValueError:
                payload["duration"] = 5

        # Pass through any extra advanced params
        for k in ["seed", "webhook", "track_id", "negative_prompt"]:
            if data.get(k) is not None:
                payload[k] = data[k]

        config = modelslab_service.get_model_config("seedance")
        result = modelslab_service.generate(config["endpoint"], config["model_id"], payload)

        media_url = _extract_output(result)
        s3_key = s3_service.upload_from_url(media_url, "seedance")

        gen = Generation(
            model_type="seedance",
            prompt=data.get("prompt", ""),
            input_params=json.dumps(data),
            s3_key=s3_key,
            media_type="video",
            status="success",
        )
        db.session.add(gen)
        db.session.commit()

        return jsonify({
            **gen.to_dict(),
            "presigned_url": s3_service.get_presigned_url(s3_key),
        })
    except Exception as e:
        traceback.print_exc()
        return jsonify({"error": str(e)}), 500


# ─── WAN 2.7 (image-to-video) ─────────────────────────────
@api_bp.route('/api/wan', methods=['POST'])
def generate_wan():
    data = request.get_json()
    if not data:
        return jsonify({"error": "Missing JSON body"}), 400

    try:
        payload = {}
        payload["prompt"] = data.get("prompt", "")

        if data.get("init_image"):
            payload["init_image"] = data["init_image"]

        # Wan 2.7 API parameters
        if data.get("duration"):
            # Enforce Integer (Modelslab throws 500 otherwise)
            try:
                payload["duration"] = int(str(data["duration"]).replace("sec", "").strip())
            except ValueError:
                payload["duration"] = 5
                
        if data.get("resolution"):
            payload["resolution"] = data["resolution"]

        for k in ["seed", "webhook", "track_id", "negative_prompt"]:
            if data.get(k) is not None:
                payload[k] = data[k]

        config = modelslab_service.get_model_config("wan")
        result = modelslab_service.generate(config["endpoint"], config["model_id"], payload)

        media_url = _extract_output(result)
        s3_key = s3_service.upload_from_url(media_url, "wan")

        gen = Generation(
            model_type="wan",
            prompt=data.get("prompt", ""),
            input_params=json.dumps(data),
            s3_key=s3_key,
            media_type="video",
            status="success",
        )
        db.session.add(gen)
        db.session.commit()

        return jsonify({
            **gen.to_dict(),
            "presigned_url": s3_service.get_presigned_url(s3_key),
        })
    except Exception as e:
        traceback.print_exc()
        return jsonify({"error": str(e)}), 500


# ─── HISTORY ───────────────────────────────────────────────
@api_bp.route('/api/generations', methods=['GET'])
def get_generations():
    model_filter = request.args.get('model_type')
    query = Generation.query.order_by(Generation.created_at.desc())
    if model_filter:
        query = query.filter_by(model_type=model_filter)
    gens = query.limit(50).all()

    result = []
    for g in gens:
        d = g.to_dict()
        if g.s3_key:
            d['presigned_url'] = s3_service.get_presigned_url(g.s3_key)
        result.append(d)
    return jsonify(result)


@api_bp.route('/api/generations/<int:gen_id>', methods=['DELETE'])
def delete_generation(gen_id):
    gen = Generation.query.get_or_404(gen_id)
    db.session.delete(gen)
    db.session.commit()
    return jsonify({"deleted": gen_id})


# ─── HELPERS ───────────────────────────────────────────────
def _extract_output(result: dict) -> str:
    """Pull the first media URL out of a Modelslab response."""
    output = result.get("output")
    if isinstance(output, list) and output:
        return output[0]
    if isinstance(output, str) and output:
        return output

    # Some endpoints nest under "data"
    data = result.get("data")
    if isinstance(data, dict):
        url = data.get("output") or data.get("url") or data.get("video_url")
        if isinstance(url, list) and url:
            return url[0]
        if isinstance(url, str) and url:
            return url

    # Fallback: look for any URL-like value
    for key in ["output_url", "video_url", "url", "result"]:
        val = result.get(key)
        if isinstance(val, str) and val.startswith("http"):
            return val
        if isinstance(val, list) and val and isinstance(val[0], str):
            return val[0]

    raise ValueError(f"Could not find output URL in Modelslab response: {json.dumps(result, indent=2)}")