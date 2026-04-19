# Flutter App

Founder-facing Flutter prototype for the MaRe Luxury Growth Engine.

Platforms enabled:

- iOS
- Android
- Web

## Includes

- luxury dashboard UI
- `json_annotation` models in `lib/shared/models/`
- mock business data
- local backend stub in `backend/`
- AI prompt and fallback notes in `agent/`

## Run

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

Run on iOS simulator:

```bash
flutter run -d ios
```

Run on Android emulator/device:

```bash
flutter run -d android
```

Run on Flutter Web:

```bash
flutter run -d chrome
```
