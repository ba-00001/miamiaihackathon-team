# Flutter App

Main `MaRe` app built in Flutter for `iOS`, `Android`, and `Web`.

## Includes

- one unified MaRe shell
- guest mode
- sign-in mock step
- role picker
- role dashboards for:
  - `MaRe Internal`
  - `Salon Owner`
  - `Client`
- `json_annotation` models in `lib/shared/models/`
- local backend stub in `backend/`
- AI prompt and fallback notes in `agent/`
- AWS S3-oriented image storage endpoints for picture uploads

## Run

```bash
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

Flutter Web:

```bash
flutter run -d chrome
```

AWS image storage env vars for the backend:

```bash
AWS_S3_BUCKET=mare-demo-assets
AWS_REGION=us-east-1
AWS_S3_PREFIX=uploads
```
