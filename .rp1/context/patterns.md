---
scope: kbRoot
path_pattern: "patterns.md"
producer: knowledge-base
type: document
description: "Implementation patterns, coding conventions, and idioms for a single-project codebase. Hard limit of 150 lines."
strictness: strict
---
# Implementation Patterns

**Project**: ELRS Mobile (Flutter / Dart; Astro website)
**Last Updated**: 2026-10-27 (commit 3e8eab5)

## Naming & Organization

**Files**: `snake_case.dart`; feature-first `lib/src/features/<feature>/{domain,data,application,services,state,presentation,utils}` (features: app_update, config, configurator, dashboard, firmware_manager, flashing, settings, splash, support) plus `lib/src/core/{networking,storage,analytics,utils,theme,presentation}`. Freezed / Riverpod siblings (`*.freezed.dart`, `*.g.dart`) via `part`.
**Classes**: `PascalCase`, role-suffixed (`*Repository`, `*Service`, `*Controller`, `*ViewModel`, `*Utils`, `*Validator`).
**Functions**: `lowerCamelCase`, verb-prefixed async (`fetchConfig`, `downloadFirmware`, `probeDevice`); private helpers `_underscored`; pure mappings as top-level functions (`chipFamilyOf`, `isExpectedRebootSocketDrop`).
**Imports**: relative within `lib/src`; `package:` for third-party and in tests. GPL-3.0 header is opportunistic, not a house rule.

Evidence: `lib/src/features/flashing/utils/chip_family.dart`, `lib/src/features/flashing/domain/flash_error.dart:1-12`

## Type & Data Modeling

- Immutable `@freezed` models: `const factory`, `fromJson`, `@Default` on optionals, `@JsonKey(name: 'snake_case')`.
- Closed outcome sets use Dart 3 **sealed classes** with `final` subclasses (`FlashError`: NoTargetSelected, NoVersionSelected, NoDeviceConnected, NoBindPhrase, ChipMismatch, FlashUnconfirmed, OfflineMissingFiles, FlashFailed, DownloadFailed), each with a stable analytics `code` and optional verbatim `detail`.
- Mutation via `state = state.copyWith(...)`; copy maps before mutating; `binary` package `Uint32`/`Uint16`/`Uint8.checkRange` for bit math and bounds.

Evidence: `lib/src/features/flashing/domain/target_definition.dart`, `flash_error.dart`, `lib/src/features/config/utils/frequency_validator.dart`

## Error Handling

**Strategy**: exceptions at the data layer (no Result/Either); repositories rethrow `Exception('Failed to ...: $e')`. Controllers convert failures into typed `FlashError` state; screens localize via `flash_error_text.dart`, keeping device/network text untranslated in `detail`. Probes swallow errors and return `bool`.
**Confirm-by-reply**: a flash succeeds only when the device JSON `status == 'ok'` (non-status replies from very old firmware = success). Mid-upload drop = failure; drop after the last byte with no reply (`uploadComplete && isExpectedRebootSocketDrop`) = `FlashUnconfirmedException`. `isExpectedRebootSocketDrop` classifies; it never implies success.
**Force flash**: re-upload with `?force=1`; call `confirmForceUpdate()` only if the device still replies `mismatch`.
**Guards fail fast**: no device, chip mismatch (hard block), empty bind phrase (prompt), product mismatch (forceable) are checked before any upload.
**Fallbacks**: tiered network → cache → bundled asset; firmware-version-gated endpoint fallback (`/config` → `/target` + `/mode.json`; `/hardware.json` → `/`), with inline comments naming the firmware range.

Evidence: `lib/src/features/flashing/data/device_repository.dart`, `presentation/flashing_controller.dart:720-880`, `lib/src/features/config/services/device_config_service.dart`

## Validation & Boundaries

- Form validation in static `*Utils` / `*Validator` returning `String?` (null = valid): `ValidationUtils` (SSID ≤ 32, password 8–63).
- External device JSON normalized by hand before Freezed parsing (V3 `settings` hoist, `reg_domain` → `domain`, `vbind` coercion).
- Hardware-safety checks throw (`FrequencyValidator`) or block (`ChipMismatch`); options JSON values sanitized (trim, strip NUL).

## Observability

- **Logging**: `package:logging`, one `static final _log = Logger('ClassName')` per class; info/warning/severe; logs URLs, byte counts, fallbacks. Never log binding phrases, SSIDs or passwords (logs become Sentry breadcrumbs). `debugPrint` remains in 5 files for bootstrap diagnostics.
- **Analytics**: `AnalyticsService.trackEvent` (Aptabase), gated by `shareAnalytics` which **defaults to true** (opt-out). Events: Firmware Downloaded / Flashed (target, version), Firmware Download / Flash Error (errorType = `FlashError.code`, error text), Config Webview Opened. Failures dropped silently.
- **Crash reporting**: Sentry starts whenever `SENTRY_DSN` is compiled in; not gated by the analytics toggle; 50 % sample; socket errors filtered in `beforeSend`. Manual debug reports add tags (app version, Expert Mode, domains, whether home SSID is set).
- Keep the website privacy policy (`website/src/components/PrivacyPage.astro`, `privacy.*` strings) in sync with any telemetry change.

Evidence: `lib/main.dart:36-90`, `lib/src/core/analytics/analytics_service.dart`, `settings_controller.dart:73`

## Testing Idioms

- Flat `test/` (8 files) named by subject. Pure unit tests for mappings/services (chip family, error text via `lookupAppLocalizations(Locale('en'))`, update service, secure-storage upgrade) and widget tests (`testWidgets`, overflow loop over `AppLocalizations.supportedLocales` at a small forced `physicalSize`).
- Hand-written fakes injected via `ProviderScope(overrides: ...)`; no mockito/mocktail.
- Repo-lint tests: `l10n_hygiene_test.dart` fails on hard-coded UI text or unused ARB keys.
- Gaps: no tests for repositories, `FirmwareAssembler`, patchers.

## UI Status & Localization

- Every UI string comes from `AppLocalizations.of(context)!`; add strings to `app_en.arb` only, translations run by manual workflow.
- Multi-phase async flows: enum + `switch` + ARB key (`FlashingStatus` locating/unpacking/downloading/building/uploading/finalizing). Label real phases; never call cache reads "downloading" (offline-first).
- Typed errors map to text in one place (`flash_error_text.dart`, `firmware_manager_error.dart`).

## I/O & Integration

- **Storage**: no SQL. `SharedPreferences` for non-sensitive prefs + flags; `FlutterSecureStorage` ^11 for profiles, active profile, bind phrase, Wi-Fi creds. `PersistenceService` owns key constants (`static const _keyXxx`) and migrations; `secure_storage_data_lost` drives a one-time reset notice.
- **HTTP**: two Dio instances, `internetDioProvider` and `localDioProvider` (`http://<ip>/`, ~2 s probe timeouts, `CancelToken`, `SequentialRequestInterceptor`). Uploads force `Content-Length` + `X-FileSize`, 120 s timeouts. Hosts hard-coded: `artifactory.expresslrs.org`, `raw.githubusercontent.com`, `cdn.elrsmobile.com/latest.json`.
- **Build flavors**: `String.fromEnvironment('DISTRIBUTION') == 'direct'` → `kIsDirectDistribution` gates update UI; `SENTRY_DSN` gates Sentry. Store builds omit both update UI and the update fetch.

## Concurrency & Async

- `async`/`await` throughout; Riverpod for reactivity; `StreamController.broadcast()` for `targetIpStream`; `compute()` for large JSON.
- `DiscoveryService._runOperation` chains a `Completer`-backed `_pendingOperation` so scans start/stop strictly in order (UDP 5353 rebind guard).
- During flash: `isFlashing` lock pauses discovery/heartbeat, wakelock on, portrait lock; unbind for downloads, rebind before upload.

## Dependency & Configuration

- `riverpod_annotation` codegen only: function providers wire collaborators via `ref.watch`; stateful controllers are `@Riverpod(keepAlive: true) class X extends _$X`. `keepAlive` for app-lifetime singletons.
- No env files; inline `static const`; build-time `--dart-define` (`SENTRY_DSN`, `DISTRIBUTION`; `dart_defines/local.json` for local runs).
- `ProviderContainer` built before `runApp`; post-first-frame bootstrap.

## Code Generation

`build_runner` (freezed, json_serializable, riverpod_generator), outputs committed; `flutter gen-l10n` from `l10n.yaml`, verified in CI.

## Website Conventions (`website/`)

- One home per fact: `src/config/locales.json`, `site.ts` (URLs/IDs), `docs.json` (sidebar + translate flag), `src/i18n/ui.json` via `useTranslations`/`format`/`formatAtLeast`; landing content in `src/data/landing.ts`; generated data in `src/data/` from scripts.
- All pages through Starlight (`StarlightPage` + overrides); Tailwind palette in `tailwind.config.mjs` feeds Starlight; analytics via `data-track` attributes; never execute `translate_astro.cjs` to test it (`node --check`).

## Hygiene

Dead-code sweeps are complete; `features/app_update` is new and live. Re-audit for new accumulation rather than assuming debt.
