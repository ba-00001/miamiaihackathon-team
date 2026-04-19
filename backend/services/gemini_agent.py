import os
import requests

class GeminiAgentService:
    def __init__(self):
        self.api_key = os.getenv("GEMINI_API_KEY")
        if not self.api_key:
            print("WARNING: GEMINI_API_KEY not found in .env")
        # FIX: Changed from gemini-1.5-pro to gemini-1.5-pro-latest
        self.url = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro-latest:generateContent?key={self.api_key}"

    def chat(self, prompt: str, system_instruction: str = None) -> str:
        if not self.api_key:
            raise ValueError("GEMINI_API_KEY is missing")

        payload = {
            "contents": [{"parts": [{"text": prompt}]}]
        }
        
        if system_instruction:
            payload["systemInstruction"] = {
                "parts": [{"text": system_instruction}]
            }

        response = requests.post(self.url, json=payload)
        
        if not response.ok:
            raise Exception(f"Gemini API Error {response.status_code}: {response.text}")

        data = response.json()
        try:
            return data['candidates'][0]['content']['parts'][0]['text']
        except (KeyError, IndexError):
            return "Error parsing Gemini response."