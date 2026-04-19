# MaRe Luxury Growth Engine

This repo is a hackathon-ready solution for the MaRe brief: help a luxury scalp-health brand expand from a Miami boutique proof point into a scalable national growth engine without losing brand quality.

The solution is split into two demo products:

- `apps/flutter_app`: a polished Flutter prototype for mobile/tablet demos.
- `apps/web_app`: a simple Next.js web app that is easy to deploy on Vercel.

Both experiences tell the same business story:

- Identify high-fit luxury salons with revenue and aesthetic signals.
- Draft luxury-standard outreach that sounds like a human insider.
- Generate scalable content for AI search, blogs, Shorts, and social.
- Keep a human approval lane before anything risky is sent or published.
- Surface AI issues as visible business events with explicit fallbacks.

## Why This Solves The Issue

MaRe's problem is not just lead generation. The real issue is scaling a luxury brand without turning it into automation spam. This solution treats growth as a guarded system:

- `Prospecting`: rank salons by luxury fit, service mix, location density, and retail upside.
- `Outreach`: generate salon-lingo messaging with hooks, value, and exclusivity guardrails.
- `Creative scaling`: produce high-volume content around scalp health, head spas, and wellness keywords.
- `Human review`: keep Rebecca, Marianna, and Growth Ops in the loop before final release.

## Repo Structure

```text
apps/
  flutter_app/
    lib/              # Flutter frontend
    backend/          # Local mock backend for the Flutter solution
    agent/            # AI agent prompt + fallback rules
  web_app/
    src/app/          # Next.js frontend + API routes
    src/lib/agent/    # Web agent logic
    public/images/    # Demo illustrations
docs/
  architecture.md
  business-technical-todos.md
  mare_pitch_deck.md
```

## Flutter Notes

The Flutter app now includes:

- `lib/shared/models/` with `json_annotation` models so JSON parsing is generated instead of handwritten.
- A luxury-styled dashboard covering prospects, outreach, content, AI watchtower, and approval queue.
- A yellow status dot shown anywhere the developer should recognize an AI-controlled or fallback-enabled surface.
- Local `backend/` and `agent/` folders to show the full solution shape, not just the UI.
- Explicit Flutter targets for `ios`, `android`, and `web`.

## Web Notes

The web app is Vercel-friendly and intentionally simple:

- Next.js App Router frontend.
- API routes at `/api/snapshot` and `/api/agent`.
- Shared data contracts mirrored from the Flutter side.
- Same yellow-dot developer marker and same AI fallback story.

## AI Errors And Fallbacks

AI errors should never create a blank screen or silent failure. In this repo, AI issues are presented as business-readable system states:

- Show the issue in an `AI Watchtower` card.
- Keep approved or cached data on screen.
- Block risky automation like outreach sends.
- Move uncertain prospects into manual review.
- Downgrade from video generation to blog/script generation if media tools fail.
- Preserve the yellow dot so the developer knows fallback mode is active.

## Business To Do

See [docs/business-technical-todos.md](docs/business-technical-todos.md) for the working list. The main business next steps are:

- connect real revenue and salon data providers
- validate partner scoring with MaRe founders
- train and tighten salon-lingo brand prompts
- define partner onboarding and revenue-share flows
- measure AI-search wins on live content

## Technical To Do

Key technical next steps:

- replace mock data with live APIs and authenticated workflows
- add persistent CRM state and approval history
- connect real multimodal providers for video and image generation
- add analytics, audit logging, and role-based access
- productionize tests, observability, and deployment pipelines

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

Optional mock backend:

```bash
cd apps/flutter_app/backend
npm run dev
```

### Web

```bash
cd apps/web_app
npm install
npm run dev
```

For production:

```bash
cd apps/web_app
npm run build
```

## Presentation

The deck content lives in [docs/mare_pitch_deck.md](docs/mare_pitch_deck.md). It is written to support a founder or judge walkthrough covering the problem, product, architecture, differentiation, ROI, and roadmap.
