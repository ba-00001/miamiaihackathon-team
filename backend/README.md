# Backend Setup (updated for Modelslab AI video + dubbing)

```bash
# macOS/Linux
python3 -m venv venv
## 1. Environment
```bash
# macOS/Linux
python3 -m venv venv
source venv/bin/activate

# Windows
python -m venv venv
venv\Scripts\activate

# Install deps
pip install -r requirements.txt

# Copy and edit your API key
cp .env.example .env
# → Edit .env and put your Modelslab key

python3 app.py

---

Wan 2.7 Image to Video
https://modelslab.com/models/alibaba_cloud/wan-2.7-image-to-video

Seedance 2.0 - Start / End Frame to Video
https://modelslab.com/models/byteplus/seedance-20-start-end-frame-image-to-video
