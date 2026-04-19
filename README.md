# miamiaihackathon-team

# Hackathon Project: Flutter + Flask Setup

This repository contains a Flutter web frontend and a Python Flask backend. Follow the instructions below to get both environments running locally.

## Prerequisites
- [Python 3.x](https://www.python.org/downloads/) installed
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed

---

## 1. Backend Setup (Flask)

The backend runs on `http://localhost:8080`.

1. Open a terminal and navigate to the backend directory:
   ```bash
   cd backend

# Terminal 1 — backend
cd backend
python3 -m venv venv && source venv/bin/activate
pip install -r requirements.txt
cp .env.example .env    # ← edit with your keys
python3 app.py          # runs on :8080

# Terminal 2 — frontend
cd frontend
flutter pub get
flutter run -d chrome --web-port 3000