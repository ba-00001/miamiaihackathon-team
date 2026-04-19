import os
import time
import requests
from dotenv import load_dotenv
from typing import Dict, Any

class ModelslabService:
    MODELS = {
        "seedance": {
            "endpoint": "https://modelslab.com/api/v7/video-fusion/image-to-video",
            "model_id": "seedance-2-start-end-frame-video"
        },
        "wan": {
            "endpoint": "https://modelslab.com/api/v7/video-fusion/image-to-video",
            "model_id": "wan2.7-i2v"
        }
    }

    MAX_POLL_TIME = 300 

    def __init__(self):
        load_dotenv()
        self.api_key = os.getenv("MODELSLAB_API_KEY")
        if not self.api_key:
            raise ValueError("MODELSLAB_API_KEY is missing from .env file")

    def _poll_for_result(self, fetch_url: str) -> Dict[str, Any]:
        start = time.time()
        while True:
            elapsed = time.time() - start
            if elapsed > self.MAX_POLL_TIME:
                raise TimeoutError(f"Modelslab job timed out after {self.MAX_POLL_TIME}s.")

            time.sleep(5)
            try:
                resp = requests.post(fetch_url, json={"key": self.api_key}, timeout=30)
                data = resp.json()
            except Exception as e:
                print(f"[poll] Request error: {e}, retrying…")
                continue

            status = data.get("status")
            if status == "success":
                return data
            if status in ["failed", "error"]:
                msg = data.get("message", data.get("error", "Unknown error"))
                raise Exception(f"Modelslab generation failed: {msg}\nFull response: {data}")

    def generate(self, endpoint: str, model_id: str, user_payload: Dict[str, Any]) -> Dict[str, Any]:
        payload = user_payload.copy()
        payload["model_id"] = model_id
        payload["key"] = self.api_key

        resp = requests.post(endpoint, json=payload, headers={"Content-Type": "application/json"}, timeout=60)
        if not resp.ok:
            raise Exception(f"Modelslab HTTP {resp.status_code}: {resp.text}")

        data = resp.json()
        if data.get("status") == "error":
            msg = data.get("message", data.get("error", "Unknown error"))
            raise Exception(f"Modelslab error: {msg}")

        fetch_url = data.get("fetch_result") or data.get("fetch_url")
        if data.get("status") == "processing" and fetch_url:
            return self._poll_for_result(fetch_url)

        return data

    def get_model_config(self, name: str):
        if name not in self.MODELS:
            raise ValueError(f"Unknown model: {name}")
        return self.MODELS[name]