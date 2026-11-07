# AICA Mobile App — Step 4A API Preparation

**Completed:** 20 October 2026  
**Project:** Cambodia Smart Traffic — AI Traffic Violation & Driver Services  
**Status:** Step 4A complete locally. Step 4B is waiting.

## 1. Purpose

Step 4A prepares the Flutter project for a future FastAPI connection. It adds API configuration, request preparation, DTO parsing, DTO-to-model conversion, and local tests.

No real backend connection, CRUD operation, authentication, payment service, or production API call was added.

## 2. Existing Project Structure Inspected

The following areas were reviewed before making changes:

- `lib/model/`
- `lib/data/`
- `lib/UI/`
- `pubspec.yaml`
- `test/`

Existing models found:

- `Vehicle`
- `Violation`
- `AppNotification`
- `OnboardingPage`

The existing `Vehicle` and `Violation` models were reused. No duplicate models were created.

## 3. New Folders and Files

```text
lib/
└── data/
    ├── api/
    │   ├── api_config.dart
    │   └── api_client.dart
    └── dto/
        ├── owner_dto.dart
        ├── vehicle_dto.dart
        └── traffic_violation_dto.dart

test/
└── dto_test.dart
```

No `Owner` UI model was created because the current application does not require one.

## 4. API Configuration

`lib/data/api/api_config.dart` contains:

- API prefix: `/api/v1`
- Health endpoint: `/health`
- Database health endpoint: `/health/db`
- Owners endpoint: `/api/v1/owners`
- Vehicles endpoint: `/api/v1/vehicles`
- Traffic violations endpoint: `/api/v1/traffic-violations`

The base URL is configured through a Dart environment value:

```shell
flutter run --dart-define=AICA_API_BASE_URL=https://your-api.example
```

The default value is `https://api.example.invalid`. It cannot accidentally connect to localhost, a LAN address, or a real server.

## 5. API Client Preparation

`lib/data/api/api_client.dart` prepares request descriptions for:

- GET
- POST
- PUT
- PATCH
- DELETE

Each request description contains:

- HTTP method
- URI
- headers
- optional JSON-compatible body

The client does not contain a network sender. Calling these methods only builds an `ApiRequest` object, so Step 4A cannot contact a backend.

No networking package was added because real HTTP communication belongs to Step 4B.

## 6. Owner DTO

`OwnerDto` parses only the known FastAPI fields:

- `id`
- `full_name`
- `phone_number`
- `created_at`

The snake_case JSON keys are converted to readable Dart properties such as `fullName` and `createdAt`.

Required fields use strict type checking. Invalid required data throws a clear `FormatException`.

## 7. Vehicle DTO and Model Mapping

`VehicleDto` parses only:

- `id`
- `owner_id`
- `plate_number`
- `vehicle_type`
- `created_at`

`VehicleDto.toModel()` converts the DTO to the existing `Vehicle` model.

Mapping rules:

| Vehicle model field | Source |
|---|---|
| `name` | Display vehicle type plus plate number |
| `type` | `vehicle_type`, formatted for display |
| `plate` | `plate_number` |
| `colour` | `Not available` placeholder |
| `year` | `0` placeholder |
| `expiry` | `Not available` placeholder |

The placeholders exist only in the mapping layer. They do not claim that FastAPI supplied those values.

## 8. Traffic Violation DTO and Model Mapping

`TrafficViolationDto` parses only:

- `id`
- `vehicle_id`
- `violation_type`
- `location`
- `occurred_at`
- `status`
- `created_at`

Backend statuses are handled exactly as follows:

| FastAPI status | Existing Flutter status |
|---|---|
| `pending` | `ViolationStatus.underReview` |
| `confirmed` | `ViolationStatus.confirmed` |
| `rejected` | `ViolationStatus.resolved` |

An unknown value throws a `FormatException`. It is never silently treated as confirmed.

Additional model mapping:

- The numeric API ID becomes a string model ID.
- `violation_type` is formatted as a display title.
- `occurred_at` provides the display date and time.
- `location` maps directly.
- Plate uses `Not available` because it is not part of the known violation response.
- Reference uses the API violation ID.
- Fine amount remains the existing model default of `0` because the known API contract has no fine amount.

## 9. Date and Validation Behavior

All API date values use `DateTime.parse()` for ISO-8601 parsing.

Parsing fails clearly when:

- an integer field is missing or is not an integer;
- a required string is missing or empty;
- a date is not valid ISO-8601;
- a violation status is not `pending`, `confirmed`, or `rejected`.

## 10. Tests Added

`test/dto_test.dart` contains 12 focused tests covering:

- Owner DTO parsing
- Vehicle DTO parsing
- Traffic violation DTO parsing
- ISO-8601 date parsing
- Invalid ISO date handling
- `pending` status
- `confirmed` status
- `rejected` status
- Unknown status rejection
- Vehicle DTO to model conversion
- Violation DTO to model conversion
- API request preparation without network communication

The sample owner, vehicle, and violation records are local test fixtures only. The production UI does not use them.

## 11. Existing Code Preserved

The following were not changed:

- Existing models
- Existing screens
- Colors and typography
- Layout and spacing
- Cards and navigation
- Demo interactions
- `demo_data.dart`
- `demo_store.dart`
- Existing widget tests
- `pubspec.yaml`

The application continues to use `DemoStore` as its active data source.

## 12. Validation Results

The required checks were run:

```text
flutter pub get     Passed
dart format lib test
                    Passed
flutter analyze     Passed — no issues found
flutter test        Passed — all 86 tests passed (current suite)
git diff --check    Passed
```

The 12 DTO/API preparation tests added in Step 4A remain part of the current 86-test suite.

## 13. Git and Remote Status

All Step 4A changes remain local.

- No Git commit was created.
- No code was pushed.
- No pull request was created.
- No branch was merged.
- Nothing was uploaded or published.

## 14. Remaining Work for Step 4B

Step 4B will require explicit authorization before work begins. Expected future work includes:

- receiving the real FastAPI base URL;
- confirming the final backend JSON contract;
- adding an HTTP transport;
- sending requests through `ApiClient`;
- decoding responses into the prepared DTOs;
- handling network and backend errors;
- replacing selected `DemoStore` reads with repository or API data;
- keeping the current UI and navigation behavior intact.

## Final Status

**Step 4A — API preparation complete**

**Step 4B — Real FastAPI integration waiting**
