# AICA — English/Khmer Localization and Light/Dark Theme

Completed locally on 20 October 2026.

## Approach

Localization uses Flutter's standard ARB generation workflow, `flutter_localizations`, and `intl`. There is no custom localization engine. `l10n.yaml` configures generation into `lib/l10n/generated/`.

There are **278 English resources and 278 Khmer resources**, including parameterized payment amounts, confirmation text, violation filter counts, and the OTP phone-number prompt. Regenerate the Dart classes after editing ARB files with `flutter gen-l10n`.

`context.l10n` accesses the generated localizations. Its English fallback supports existing isolated widget tests. `demo_labels.dart` maps known demo record IDs and stable preference keys to generated display labels; it does not change the underlying models or records.

## New Files

- `l10n.yaml`
- `lib/l10n/app_en.arb`
- `lib/l10n/app_km.arb`
- `lib/l10n/l10n_context.dart`
- `lib/l10n/demo_labels.dart`
- `lib/l10n/generated/app_localizations.dart`
- `lib/l10n/generated/app_localizations_en.dart`
- `lib/l10n/generated/app_localizations_km.dart`
- `lib/theme/app_colors.dart`
- `lib/theme/app_theme.dart`
- `test/localization_theme_test.dart`
- This report

## Existing Files Updated for This Task

- `pubspec.yaml` and `pubspec.lock`: Flutter localization dependencies and generation.
- `lib/main.dart`: localization delegates, supported locales, reactive locale selection, light/dark themes, and `ThemeMode`.
- `lib/data/demo_store.dart`: restore and save the existing dark-mode state.
- `lib/data/local/local_storage_service.dart`: dark-mode preference and clearing behavior.
- Existing UI screens and `app_components.dart`: generated localized strings, theme-aware surfaces/text/borders/status colors, font fallback, and wrapping for longer labels.
- `lib/data/permissions/notification_permission_service.dart`: an Android-only availability check for the Linux preview. Android permission behavior is retained.

Earlier uncommitted work from Steps 4A, 6, 7, and UI QA was preserved.

## Localized Screens and Copy

- Onboarding, sign-in, and OTP verification
- Home and bottom navigation
- Violations, filters, search, status badges, details, and explanation sheet
- Appeals and submission confirmation
- Payments, history labels, review, confirmation dialog, and demo completion
- Vehicles, vehicle creation sheet, vehicle details, and verification steps
- Driving licence and demo points notices
- Notifications and demo notification messages
- Profile, language sheet, and dark-mode setting
- Notification preferences and permission messages
- Personal information, privacy/security, and help/support
- Buttons, form labels, helper text, empty states, and demo disclaimers

Plate numbers, dates, phone numbers, monetary values, references, names, and vehicle brands remain unchanged. Language names are shown in their native form so users can recover their preferred language.

## Language Switching and Persistence

`DemoStore.languageCode` remains the single language source of truth. Both existing selectors call `setLanguage('en')` or `setLanguage('km')`.

`SmartTrafficApp` listens to the store and updates `MaterialApp.locale` immediately. Existing navigation is retained. The existing local-storage language value is loaded before `runApp`, so the app starts in the saved language.

## Khmer Rendering and Layout

`Plus Jakarta Sans` is the Latin font family (bundled in `assets/fonts`), with `Noto Sans Khmer`, `Khmer OS`, and the platform sans-serif as fallbacks. Noto Sans Khmer was confirmed installed on the Linux host. Explicit widget styles and button/dialog styles include the same fallback.

Longer labels can wrap in navigation, menu rows, status badges, vehicle verification steps, and licence-card columns. No smaller font was introduced to force Khmer into a fixed space.

Existing Material icons replace missing emoji in vehicle selectors and payment controls. The phone prefix keeps `+855` without relying on flag emoji support.

## Light and Dark Themes

`buildLightTheme()` preserves the existing light palette, dimensions, and blue buttons.

`buildDarkTheme()` starts from Flutter's dark defaults and applies AICA colors:

| Role | Dark color |
|---|---|
| Page background | `#0E1928` |
| Card/sheet surface | `#172536` |
| Main text | `#E6EDF5` |
| Muted text | `#AFBED0` |
| Border | `#3B4D63` |
| Text/icon blue accent | `#8BB4FF` |
| Primary filled button | `#2563EB` |

Status text and matching backgrounds retain red, amber, purple, green, and blue meanings with readable dark counterparts. Their labels and icons remain present.

The existing Profile switch controls `DemoStore.darkMode`, which updates `ThemeMode.light` or `ThemeMode.dark` immediately.

## Stored Preferences

`LocalStorageService` now persists exactly:

- Onboarding completion
- Language code
- Read notification IDs
- Dark-mode preference (`is_dark_mode`)

Dark mode defaults to false. Storage failures use safe defaults. `clearLocalPreferences()` removes the theme preference along with the other local settings.

No credentials, OTPs, tokens, payment credentials, or official records were added to local storage.

## Tests

Fourteen new tests cover:

- English and Khmer major labels and parameterized messages
- Default English and light mode
- Saving/restoring language and theme through a new store
- Immediate locale and `ThemeMode` updates
- Actual Profile selector/switch behavior without losing navigation
- Dark status-color contrast of at least 4.5:1 for tested text/background pairs
- Safe Android-only permission availability in the Linux preview
- Nineteen screen types at 320 logical pixels in all four language/theme combinations
- Language, vehicle, and explanation sheets in all four combinations
- Payment confirmation and completion in all four combinations

All **86 tests pass** in the current suite.

## Validation

| Check | Result |
|---|---|
| `flutter pub get` | Passed |
| `dart format lib test` | Passed |
| `flutter analyze` | No issues |
| `flutter test` | 86 passed (current suite) |
| `git diff --check` | Passed |
| `flutter run -d linux` | Built and launched |

Temporary real-font Flutter captures were rendered for Home, Violations, Payments, Profile, Language, Personal information, Notification preferences, Add vehicle, and Payment dialog in all four combinations. Captures are under `/tmp/aica-localization-previews/`; the temporary capture test was removed because it depended on host font paths.

The initial native Linux screen was inspected. A complete interactive native Linux walkthrough in all four combinations was not verified: native window capture/input became unreliable during the walkthrough. Rendered previews and automated checks are reported separately from native testing.

## Remaining Verification and Limitations

- Android hardware font rendering, keyboard behavior, system insets, and the real permission dialog still require device testing.
- Khmer font availability depends on platform fallback fonts; no font files were downloaded or bundled.
- Existing demo records have translated display labels. Unknown future backend descriptions will need their own localization policy during integration.
- No claim of pixel-perfect Figma parity or complete native Linux manual verification is made.

## Scope and Git Status

API configuration and DTO files were not changed. No HTTP transport, backend connection, real CRUD, authentication, push service, or real payment integration was added.

All changes remain local. No commit, push, pull request, merge, upload, or publication was performed.

**Step 6B — Localization complete**

**Step 6C — Dark mode complete**

**Step 4B — Still waiting**

**Step 5 — Still waiting**

**Step 8 — Not started**
