# Web App

Simple Flask + Python version of the MaRe Luxury Growth Engine.

## Includes

- Flask server-rendered dashboard
- JSON endpoints for snapshot, agent state, and AWS image storage
- AWS S3-oriented storage service for picture uploads
- Vercel-compatible Python entrypoint in `api/index.py`
- demo illustrations and yellow-dot AI marker

## Run

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python app.py
```

## AWS Image Storage Env Vars

```bash
AWS_S3_BUCKET=mare-demo-assets
AWS_REGION=us-east-1
AWS_S3_PREFIX=uploads
AWS_ACCESS_KEY_ID=...
AWS_SECRET_ACCESS_KEY=...
```

If AWS credentials are not set, the app stays in safe demo mode and returns a predictable S3-style target instead of a live signed upload.
