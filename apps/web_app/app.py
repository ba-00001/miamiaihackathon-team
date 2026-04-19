from flask import Flask, jsonify, render_template, request

from data.mock_data import AGENT_STATE, MARE_APP_SNAPSHOT
from services.aws_storage import S3ImageStorageService


app = Flask(__name__)
storage_service = S3ImageStorageService()


@app.get("/")
def index():
    view = request.args.get("view", "welcome")
    role_id = request.args.get("role")
    current_role = next(
        (role for role in MARE_APP_SNAPSHOT["roles"] if role["id"] == role_id), None
    )

    return render_template(
        "index.html",
        app_data=MARE_APP_SNAPSHOT,
        agent=AGENT_STATE,
        storage=storage_service.storage_summary(),
        view=view,
        current_role=current_role,
    )


@app.get("/api/snapshot")
def snapshot():
    return jsonify(MARE_APP_SNAPSHOT)


@app.get("/api/app-state")
def app_state():
    return jsonify(MARE_APP_SNAPSHOT)


@app.get("/api/agent")
def agent():
    return jsonify(AGENT_STATE)


@app.get("/api/storage/config")
def storage_config():
    return jsonify(storage_service.storage_summary())


@app.post("/api/storage/prepare-upload")
def prepare_upload():
    payload = request.get_json(silent=True) or {}
    filename = payload.get("filename", "mare-image.jpg")
    return jsonify(storage_service.prepare_upload(filename))


if __name__ == "__main__":
    app.run(debug=True, host="127.0.0.1", port=5000)
