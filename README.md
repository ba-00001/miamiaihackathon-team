# MaRe Production Demo Ready

## Flutter App (Production Builds Ready)
```bash
cd miamiaihackathon-team/apps/flutter_app
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter build apk --release # or ios/web
```

Backend (AWS Ready):
```bash
cd backend
npm run dev # Running on :4300
```

## Pitch Deck
docs/MaRe_Luxury_Growth_Engine.pptx - 10-slide MaRe luxury growth engine deck.
docs/mare_pitch_deck.md - Markdown version.
docs/generate_pitch_deck.py - PPTX generator.

## Features Complete
- Real backend API integration (Dio, fallback mocks).
- State mgmt (Provider).
- Mock auth (concierge@mareheadspa.com / mare-private).
- Yellow dot AI/fallback UI.
- Responsive luxury UI for all roles.
- AWS S3 presign ready.

**Demo**: Backend terminal running. Flutter Chrome shows app with API calls, buttons functional (signin, roles). All mockups as fallbacks.

**Pitch**: Open pptx for hackathon slides. Brand assets in assets/images (growth_flow.svg, mare_hero.svg).

Ready for production demo/presentation. No MaRe Brand Assets dir found, using existing SVGs.
