# Web App

Simple Flask + Python version of the unified `MaRe` app.

## Includes

- welcome screen
- guest mode
- sign-in mock step
- role picker
- role dashboards for internal, salon-owner, and client views
- JSON endpoints for app state, agent state, and AWS image storage
- AWS S3-oriented storage service for picture uploads
- Vercel-compatible Python entrypoint in `api/index.py`

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
