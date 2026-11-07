# Cambodia Smart Traffic Flutter demo

A Flutter implementation of the screens and flows visible in the supplied Figma Make prototype.

## Run

```sh
flutter pub get
flutter run
```

Sign in with the temporary test account:

```text
phone: 12345678
code:  123456
```

No SMS is sent. The test account lives in `lib/data/auth/user_repository.dart`.

## Structure

```text
lib/
├── UI/                  # Screens, navigation and reusable widgets
│   └── widgets/
├── data/                # Sample records, demo state and local storage
│   ├── api/             # Prepared API config and request builder (no transport yet)
│   ├── auth/            # Temporary in-app test user repository
│   ├── dto/             # Backend DTO parsing and model mapping
│   ├── local/           # SharedPreferences wrapper
│   └── permissions/     # Android notification permission service
├── l10n/                # English/Khmer ARB files and generated localizations
├── model/               # Violation, vehicle, notification and onboarding types
├── theme/               # Color tokens, fonts and light/dark themes
└── main.dart            # App entry point
```

The app includes onboarding, demo sign-in, dashboard, violation search and filters, detail pages, appeals, payment review and history, vehicles, licence, notifications, and profile/settings screens. Sample records come from `lib/data/demo_data.dart`.

English and Khmer localization plus light/dark theming are implemented; the language and theme choices are persisted locally. Onboarding completion, language, theme, notification read state, notification preferences, and the signed-in test session survive a restart.

The test user repository is a temporary fixture while there is no database. The test phone number and code are compiled into the app, so they must never be used for real accounts. Replace `TestUserRepository` with an API-backed repository and server-side OTP verification before public release.

This is a local prototype. Demo payment only marks records paid in memory after confirmation; it does not transfer money. Appeals and profile changes are also in memory and reset when the app restarts. SMS, real evidence video, evidence uploads, government payment and registry services, support, and the FastAPI backend (Step 4B) still need integrations or implementation. The licence points preview is explicitly labelled as demo data.

Run checks with `flutter analyze` and `flutter test`.
