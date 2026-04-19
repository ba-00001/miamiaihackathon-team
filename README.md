# MaRe

MaRe is one unified luxury scalp-health app with four experiences inside the same shell:

- `Guest`
- `MaRe Internal`
- `Salon Owner`
- `End User`

The app starts with a welcome screen, offers a guest path for public exploration, then routes signed-in users through role selection before loading the right dashboard.

## Product Model

MaRe is not built as separate apps. It is one product with role-aware routing:

1. `Guest`
   Browse public education, partner-salon discovery, session expectations, product discovery, and partner/distributor application paths.
2. `MaRe Internal`
   Prospect premium partners, review AI outputs, manage outreach, route territory/distributor leads, approve content, and run partner growth.
3. `Salon Owner`
   Track partner analytics, MaRe Eye media, training and certification, staff enablement, and reorder flows.
4. `End User`
   Find partner locations, review scalp journey, appointments, progress images, routines, shopping, and member updates.

## Updated Plan

The current build plan now combines your original hackathon scope, the later role-selection changes, and the official MaRe website positioning:

1. Keep `MaRe` as one unified app with a shared login system, guest mode, AI layer, and AWS-backed picture storage.
2. Support `Guest`, `MaRe Internal`, `Salon Owner`, and `End User` flows inside the same shell with role switching after sign in.
3. Open the experience as the `MaRe` brand first, not as a visible role chooser, so the first impression feels like a real luxury product.
4. Attach a clear persona to each experience so the product team and developers know exactly who each surface is serving.
5. Make `Guest` mode strong enough to show real brand value:
   partner-location discovery, session expectations, scalp-health education, membership signup, and product browsing.
6. Make `MaRe Internal` serve the real business team:
   `MaRe growth lead`, `MaRe sales team`, and `prospect salon pipeline managers`.
7. Expand internal tools around premium-partner targeting:
   salons, spas, clinics, hotels, wellness centers, and distributor opportunities.
8. Keep internal AI guarded:
   prospect scoring, outreach generation, content generation, and review queues with visible fallback states and the yellow dot.
9. Make the `Salon Owner` role reflect the official MaRe partner story:
   MaRe Eye diagnostics, visit history, protocol recommendations, training, certification, wholesale support, and marketing assets.
10. Make the `End User` role reflect the official MaRe consumer story:
   find partner locations, book sessions, understand what to expect, and shop products like washes, shampoos, rinses, tools, light therapy, and gift kits.
11. Remove visible prototype language from the user-facing UI so the experience feels real and premium even while backend behavior remains safely staged.
12. Keep the Flutter app as the main cross-platform client for `iOS`, `Android`, and `Web`, and keep the simple app as the Flask + Python version.
13. Use the same data model across both apps for salon profiles, outreach drafts, incentives, AI fallbacks, and AWS image storage.

## Personas

- `Guest`: `Sophia Vale`, a high-earning wellness enthusiast looking for a refined ritual, the right location, and product confidence before she books.
- `MaRe Internal`: `Avery Laurent`, a growth lead who needs selective expansion, premium partner targeting, and human-reviewed AI assistance.
- `Salon Owner`: `Isabella Moreau`, a partner operator who wants prestige, staff confidence, certification, and measurable retail lift.
- `End User`: `Camille Ashford`, a discerning client who wants partner discovery, a personalized treatment journey, and recommendation-led shopping.

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
- role-aware experiences for `MaRe Internal`, `Salon Owner`, and `End User`
- `json_annotation` models in `lib/shared/models/`
- salon profile, outreach draft, and incentive calculation contracts for internal CRM flows
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
- JSON endpoints for app state, AI state, storage, salon profiles, and outreach drafts

## Website-Grounded Features

The current product story also reflects the official `mareheadspa.com` positioning:

- professionals include salons, spas, clinics, hotels, wellness centers, and distributors
- wellness enthusiasts can explore education, member updates, session expectations, locations, and products
- the MaRe system includes `MaRe Eye`, the `MaRe Capsule`, Italian clean-beauty products with Philip Martin's, and scalp/hair tools
- end users should be able to find products like `Purifying Wash`, `In Amber Wash`, and related scalp-care items
- session flow should show AI scalp scan, questionnaire, treatment plan, immersive ritual, and post-treatment home-care recommendations

## AWS Image Storage

Both versions use the same picture-storage model:

- `AWS S3` for scalp images, before/after photos, generated assets, and campaign media
- safe fallback mode when live signing credentials are unavailable
- upload-preparation endpoints for future presigned upload flows

## AI and Fallback Rules

AI never acts as silent automation.

- guest users only see public education
- salon owners only see partner data
- end users only see their own journey
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

- connect live salon, partner, and end-user data sources
- implement real auth and role mapping
- move mock storage prep into real presigned S3 uploads
- integrate real LLM and multimodal providers
- add analytics, CRM state, and audit logs

## Presentation

The pitch materials live in:

- [docs/mare_pitch_deck.md](docs/mare_pitch_deck.md)
- [docs/MaRe_Luxury_Growth_Engine.pptx](docs/MaRe_Luxury_Growth_Engine.pptx)
