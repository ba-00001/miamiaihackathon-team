# MaRe

MaRe is one unified luxury scalp-health app with four experiences inside the same shell:

- `Guest`
- `MaRe Internal`
- `Salon Owner`
- `Client`

The app starts with a welcome screen, offers a guest path for public exploration, then routes signed-in users through role selection before loading the right dashboard.

## Product Model

MaRe is not built as separate apps. It is one product with role-aware routing:

1. `Guest`
   Browse public education, brand storytelling, partner-salon discovery, and a partner-application path.
2. `MaRe Internal`
   Prospect salons, review AI outputs, manage outreach, approve content, and run partner growth.
3. `Salon Owner`
   Track partner analytics, MaRe Eye media, staff enablement, and reorder flows.
4. `Client`
   Review scalp journey, appointments, progress images, routines, and shopping.

## Repo Structure

```text
apps/
  flutter_app/
    lib/              # Main MaRe Flutter frontend for iOS, Android, and Web
    backend/          # Local mock backend for MaRe app-state and storage APIs
    agent/            # AI prompt + fallback rules
  web_app/
    app.py            # Flask entrypoint for the simple web version
    templates/        # Server-rendered MaRe shell with guest/sign-in/roles
    static/           # CSS + demo images
    services/         # AWS S3 storage service
    api/              # Vercel-compatible Python entrypoint
docs/
  architecture.md
  business-technical-todos.md
  mare_pitch_deck.md
```

## Flutter App

The Flutter app is the main cross-platform MaRe client and now includes:

- one `MaRe` shell for `guest`, `sign in`, `role picker`, and `role dashboards`
- role-aware experiences for `MaRe Internal`, `Salon Owner`, and `Client`
- `json_annotation` models in `lib/shared/models/`
- explicit Flutter targets for `ios`, `android`, and `web`
- AWS S3-oriented storage endpoints in the local backend
- yellow-dot AI/fallback marker wherever AI logic or guarded output is active

## Simple Web Version

The simple web version uses `Flask + Python` and mirrors the same product flow:

- welcome screen
- guest mode
- sign-in mock step
- role picker
- role-specific dashboards
- JSON endpoints for app state, AI state, and storage

## AWS Image Storage

Both versions use the same picture-storage model:

- `AWS S3` for scalp images, before/after photos, generated assets, and campaign media
- safe fallback mode when live signing credentials are unavailable
- upload-preparation endpoints for future presigned upload flows

## AI and Fallback Rules

AI never acts as silent automation.

- guest users only see public education
- salon owners only see partner data
- clients only see their own journey
- internal teams can generate drafts but risky actions stay gated
- uncertain AI output falls back to templates or review queues
- the yellow dot shows AI-managed or fallback-enabled surfaces

## Run The Demos

### Flutter

```bash
cd apps/flutter_app
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

iOS:

```bash
flutter run -d ios
```

Android:

```bash
flutter run -d android
```

Web:

```bash
flutter run -d chrome
```

Optional local backend:

```bash
cd apps/flutter_app/backend
npm run dev
```

AWS env vars for the backend:

```bash
AWS_S3_BUCKET=mare-demo-assets
AWS_REGION=us-east-1
AWS_S3_PREFIX=uploads
```

### Simple Web

```bash
cd apps/web_app
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python app.py
```

AWS picture storage env vars:

```bash
AWS_S3_BUCKET=mare-demo-assets
AWS_REGION=us-east-1
AWS_S3_PREFIX=uploads
AWS_ACCESS_KEY_ID=...
AWS_SECRET_ACCESS_KEY=...
```

## Business and Technical To Do

See [docs/business-technical-todos.md](docs/business-technical-todos.md).

The main next steps are:

- connect live salon and client data sources
- implement real auth and role mapping
- move mock storage prep into real presigned S3 uploads
- integrate real LLM and multimodal providers
- add analytics, CRM state, and audit logs

## Presentation

The pitch materials live in:

- [docs/mare_pitch_deck.md](docs/mare_pitch_deck.md)
- [docs/MaRe_Luxury_Growth_Engine.pptx](docs/MaRe_Luxury_Growth_Engine.pptx)
