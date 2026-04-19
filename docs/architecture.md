# Architecture Overview

## Product Shape

MaRe is one app with four entry states:

- `Welcome`
- `Guest`
- `Signed in → Role Picker`
- `Role Dashboard`

After sign in, the same user can switch between:

- `MaRe Internal`
- `Salon Owner`
- `Client`

## Flutter App

- Frontend: Flutter shell for iOS, Android, and Web
- Routing model: welcome → guest/sign-in → role picker → role dashboard
- Data layer: shared `json_annotation` models under `lib/shared/models/`
- Backend: lightweight Node mock service in `apps/flutter_app/backend/`
- AI layer: prompt and fallback playbook in `apps/flutter_app/agent/`
- Image storage: AWS S3-oriented upload prep endpoints for salon and client pictures

## Simple Web App

- Frontend: Flask server-rendered UI in `apps/web_app/templates/`
- Backend: Flask JSON routes in `apps/web_app/app.py`
- AI layer: Python-backed app state and guarded fallback logic
- Image storage: AWS S3 service in `apps/web_app/services/aws_storage.py`

## Core Domains

- `GuestExperience`
- `RoleExperience`
- `ExperienceSection`
- `ExperienceCard`
- `AiErrorState`
- `StorageProfile`

## Operating Model

1. Guest users explore public MaRe education and salon discovery.
2. Signed-in users authenticate once.
3. The app shows the available roles for the session.
4. Each role loads its own dashboard inside the same MaRe shell.
5. Images and media assets flow through AWS S3-compatible storage.
6. AI output stays role-aware, guarded, and reviewable.
7. The yellow dot marks AI-managed or fallback-enabled surfaces.
