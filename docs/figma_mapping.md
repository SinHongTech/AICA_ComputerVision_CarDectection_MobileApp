# AICA Figma to Flutter mapping

The connected Figma MCP enumerated these Make resources:

- Figma Make file: `iIFsWjqWJeq6g84cZSU6zT` — **Develop (Copy)**
- Root node: `0:1`
- Make source groups: `src/App.tsx`, `src/screens/auth.tsx`,
  `src/screens/main.tsx`, `src/screens/more.tsx`, `src/ui.tsx`, and
  `src/store.tsx`

Figma Make exposes this project as runnable source rather than individual Design
frame nodes. This connection returned source file links but rejected reads of
their contents (`Unknown resource`), so the file bodies could not be inspected.
The live Make preview was inspected screen by screen, including its rendered DOM
and styling classes. The mapping below follows those screens and the MCP source
groups.

| Figma screen or component | Flutter implementation |
| --- | --- |
| App root and flow | `lib/main.dart` |
| Splash startup | `lib/UI/splash_screen.dart` |
| Onboarding | `lib/UI/onboarding_screen.dart` |
| Sign in | `lib/UI/sign_in_screen.dart` |
| OTP verification | `lib/UI/verify_screen.dart` |
| Main app and bottom navigation | `lib/UI/app_shell.dart` |
| Home | `lib/UI/home_screen.dart` |
| Violations list and filters | `lib/UI/violations_screen.dart` |
| Violation detail / AI alert | `lib/UI/violation_detail_screen.dart` |
| Appeal/dispute | `lib/UI/appeal_screen.dart` |
| Payments and history | `lib/UI/payments_screen.dart` |
| Review payment | `lib/UI/review_payment_screen.dart` |
| Payment processing, success and demo receipt | `lib/UI/payment_flow_screens.dart` |
| Vehicles | `lib/UI/vehicles_screen.dart` |
| Vehicle detail | `lib/UI/vehicle_detail_screen.dart` |
| Driving licence | `lib/UI/licence_screen.dart` |
| Notifications | `lib/UI/notifications_screen.dart` |
| Profile | `lib/UI/profile_screen.dart` |
| Personal information and settings pages | `lib/UI/settings_screen.dart` |
| Shared panels, badges, cards, rows and navigation helpers | `lib/UI/widgets/app_components.dart` |
| Make demo state | `lib/data/demo_store.dart` |

## Design tokens used in Flutter

- Primary blue: `#2563EB`
- Dark ink/navy: `#102A43`
- App background: `#F8FAFC`
- Muted text: `#526579`
- Card border: `#C9D5E2`
- Main content width: responsive up to 390 logical pixels
- Primary button height: 52 logical pixels
- Primary button radius: 16 logical pixels
- General card radius: 20 logical pixels

## Assets

The Make source exposes `src/assets/logo.png`, `public/favicon.svg`, and ten
generated PNG image resources. The current Flutter prototype uses the reusable
code-drawn `TrafficIllustration` and Material icons. Exact Make image resource
bytes were not exported into the repository because Make resource links are not
normal Design asset exports. These remain the known visual placeholders:

- AICA logo: Material traffic icon
- Onboarding artwork: `lib/UI/widgets/traffic_illustration.dart`
- Evidence video: styled local placeholder in the violation detail screen
- Vehicle artwork: Material vehicle icons

## Known differences

- Flutter uses the platform Material icon set where Make uses web icons.
- The app uses the device status and navigation bars; Figma/device chrome is not
  drawn into Flutter.
- Evidence media, official registry data, real SMS, and payment services remain
  outside the visual parity scope.
- Demo payment, appeal, notification-read state, and profile edits reset when the
  app process restarts.
- English and Khmer localization plus light/dark theming are implemented with the
  standard ARB workflow; see `STEP_6B_6C_LOCALIZATION_THEME.md`.

## Final visual pass

- The sign-in form now uses the flag and keeps its action at the bottom, as in
  Make. OTP uses the Make disabled-button color and the six separate input boxes.
- Shared violation badges now use icons, the Make colors, and matching spacing.
  Violation and payment rows, selected bottom navigation width, and detail page
  headers were aligned with the preview.
- Payment selection controls and history badges, linked vehicle violations,
  profile menu rows, the language sheet, and settings inputs/menu rows were
  aligned with the preview.
- A 320 logical-pixel widget test checks the four main tabs for layout overflow.

The remaining visible differences are the exact Make logo/illustration and
evidence media assets, Material icons versus Make's web icon font, and device
specific font rendering. Pixel parity has not been verified on Android hardware.
