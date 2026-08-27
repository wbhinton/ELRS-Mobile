---
scope: kbRoot
path_pattern: "patterns.md"
producer: knowledge-base
type: document
description: "Implementation patterns, coding conventions, and idioms for a single-project codebase. Hard limit of 150 lines."
strictness: strict
---
# Implementation Patterns

**Project**: ELRS Mobile (Flutter / Dart)
**Last Updated**: 2026-08-27

## Naming & Organization

**Files**: `snake_case.dart`. Feature-first layout: `lib/src/features/<feature>/{domain,data,application,services,state,presentation,utils}` plus `lib/src/core/{networking,storage,theme,utils,analytics,presentation}`. Freezed (`*.freezed.dart`) and Riverpod codegen (`*.g.dart`) siblings via `part` directives.
**Classes**: `PascalCase`, role-suffixed — `*Repository`, `*Service`, `*Controller`, `*ViewModel`, `*Utils`, `*Validator`.
**Functions**: `lowerCamelCase`; verb-prefixed async methods (`fetchConfig`, `downloadFirmware`, `probeDevice`, `restartScan`). Private helpers underscore-prefixed (`_normalizeV3Config`, `_parseTargets`).
**Imports**: relative within `lib/src` (`../../core/...`); `package:` for third-party. GPL-3.0 header block on core/feature source (domain models often omit it).

Evidence: `lib/src/features/flashing/data/targets_repository.dart:1-14`, `lib/src/features/config/services/device_config_service.dart:13-21`

## Type & Data Modeling

**Data representation**: immutable domain models via `@freezed` abstract classes with `const factory` + `fromJson`/`toJson`. `@Default(...)` on every optional field; `@JsonKey(name: 'snake_case')` maps wire names. Plain holders (`FirmwareData`) use a `const` constructor with `required` finals. Untyped device payloads stay as `Map<String, dynamic>`.
**Type strictness**: standard `flutter_lints` (`analysis_options.yaml`), no extra strictness. Heavy explicit casts on decoded JSON (`as Map<String, dynamic>`, `as String`). `FrequencyValidator` uses `binary` package `Uint32`/`Uint16` wrappers for type-safe bit math.
**Immutability**: Freezed models fully immutable; mutation is `state = state.copyWith(...)`. Config normalization copies maps (`Map<String, dynamic>.from(...)`) before mutating.

Evidence: `lib/src/features/flashing/domain/target_definition.dart:6-48`, `lib/src/features/config/utils/frequency_validator.dart:1-23`

## Error Handling

**Strategy**: exception-based (no `Result`/`Either`). Repository/service methods wrap `try/catch` and rethrow `Exception('Failed to ...: $e')` with a contextual message; low-level cause appended via interpolation. Predicate probes (`probeDevice`) swallow errors and return `bool`.
**Propagation**: catch at the data/service boundary, re-wrap, bubble to the controller which stores `errorMessage` in Freezed state. `rethrow` when the caller needs the original type (`DioException`). Tiered fallback on failure (network -> cache -> bundled asset).
**Expected-error-as-success**: `DioException`s matching known connection-drop fragments after `/update`, `/forceupdate`, `/reboot` are treated as success (the device reboots and severs Wi-Fi).

Evidence: `lib/src/features/flashing/data/targets_repository.dart:16-53`, `lib/src/features/config/services/device_config_service.dart:174-209`

## Validation & Boundaries

**Location**: two layers — form-input validation in `*Utils`/`*Validator` static methods returning `String?` (null = valid, Flutter `FormField` convention); and defensive runtime normalization of external device JSON before model parsing.
**Method**: manual length/range checks (`ValidationUtils.validateSsid`/`validatePassword`). Firmware-version schema drift handled by hand-written normalizers that hoist/rename keys (V3 `settings` block, `reg_domain` -> `domain`, `vbind` bool/string -> int) so the Freezed model sees one shape. Hardware-safety asserts throw (`FrequencyValidator`).

Evidence: `lib/src/core/utils/validation_utils.dart:1-27`, `lib/src/features/config/services/device_config_service.dart:60-98,211-295`

## Observability

**Logging**: `package:logging` throughout — one `static final _log = Logger('ClassName')` per class; levels info/warning/severe. Services log request URLs, byte counts, fallback transitions, and suppressed "expected" errors. `debugPrint` only in `AnalyticsService`.
**Metrics**: product analytics via Aptabase (`AnalyticsService.trackEvent`), gated on the `shareAnalytics` opt-in with lazy init; failures logged and dropped, never thrown. No app performance metrics.
**Tracing / crash reporting**: Sentry (`sentry_flutter`) — `SentryWidgetsFlutterBinding` in `main.dart`, `Sentry.init()` after first frame when `--dart-define SENTRY_DSN` is set (opt-in; 50% sample rate; benign socket errors filtered). Log records piped to `Sentry.addBreadcrumb`; `Stm32FirmwarePatcher` / `FirmwareAssembler` report bounds-check violations. No request/correlation IDs.

Evidence: `lib/main.dart:20-45`, `lib/src/core/analytics/analytics_service.dart:13-50`, `lib/src/features/flashing/utils/stm32_firmware_patcher.dart`

## Testing Idioms

**Organization**: minimal — a single `test/localization_overflow_test.dart`, not mirroring `lib/`. No unit tests for repositories/services/assembler.
**Fixtures**: hand-written `Mock*` classes (`MockConfigViewModel`, `MockFirmwareCacheService`) injected via `ProviderScope(overrides: [provider.overrideWith(...)])`. No mockito/mocktail.
**Levels**: widget tests only — `testWidgets` + `tester.runAsync`, a parametrized loop over `AppLocalizations.supportedLocales` with a small forced `tester.view.physicalSize` to catch layout overflow.

Evidence: `test/localization_overflow_test.dart:1-60`

## I/O & Integration

**Storage**: no SQL DB. `SharedPreferences` for non-sensitive prefs + one-time migration flags; `FlutterSecureStorage` (`AndroidOptions(encryptedSharedPreferences: true)`) for bind phrase, Wi-Fi creds, and the JSON-encoded `FlashingProfile` list. `PersistenceService` owns all key constants (`static const _keyXxx`) and runs `migrateIfNeeded()` at provider creation. Firmware/targets archives cached on disk via `FirmwareCacheService`.
**HTTP clients**: Dio, two injected instances — `internetDioProvider` for public endpoints, `localDioProvider` for the LAN device (`http://<ip>/`). Short (~2 s) `sendTimeout`/`receiveTimeout` for device probes; `responseType: bytes`/`plain` for downloads; `CancelToken` threaded through device calls. Large JSON parsed off-isolate via `compute(_parseTargets, ...)`. External hosts hardcoded (`artifactory.expresslrs.org`, `raw.githubusercontent.com`).
**Resilience**: tiered fallback (network -> on-disk cache -> bundled asset); forced `Content-Length` to bypass chunked upload encoding on flash.

Evidence: `lib/src/core/storage/persistence_service.dart:9-70,148-157`, `lib/src/features/flashing/data/firmware_repository.dart:35-98`

## Concurrency & Async

**Async usage**: `async`/`await` pervasive in data/service/controller layers; UI reactive via Riverpod. Streams for discovery — `StreamController<String?>.broadcast()` exposing `targetIpStream`. Isolates via `compute` for CPU-bound JSON flattening.
**Serialization**: manual operation queueing to avoid socket races — `DiscoveryService._runOperation` chains a `Completer`-backed `_pendingOperation` future so start/stop/restart scans run strictly sequentially; teardown fully awaited before clearing `_isScanning` (UDP 5353 rebind guard). `SequentialRequestInterceptor` serializes all device HTTP (ESP8285 crashes under concurrency).
**Safety**: guard clauses check connectivity / `isFlashing` before acting. Expected transport drops (`ECONNRESET`/`EPIPE` on reboot, mDNS `SocketException`) matched and swallowed.

Evidence: `lib/src/core/networking/discovery_service.dart:57-171`, `lib/src/core/networking/device_dio.dart`

## Dependency & Configuration

**DI pattern**: `riverpod_annotation` codegen exclusively (~22 provider files). Function providers (`@riverpod X xRepository(Ref ref)`) build services from other providers via `ref.watch`; stateful controllers are `@Riverpod(keepAlive: true) class Xxx extends _$Xxx` with `build()` returning initial state and mutation methods calling `ref.read(...)`. Services take collaborators as positional constructor args; providers do the wiring. `keepAlive: true` for app-lifetime singletons (discovery, analytics, `targetIp`, `isFlashing`).
**Config loading**: no config files / env files. Constants inline as `static const` (Aptabase app id, Artifactory URLs, storage keys, default domains). Build-time values via `String.fromEnvironment` (`SENTRY_DSN`). User settings via `SettingsController`; secrets in `FlutterSecureStorage`.
**Initialization**: `ProviderContainer` created pre-`runApp` in `main.dart`; `UncontrolledProviderScope` wraps `App`; post-first-frame bootstrap (`autoBindIfWiFi`, `loadSettings`, `Sentry.init`).

Evidence: `lib/src/features/flashing/data/firmware_repository.dart:214-218`, `lib/src/core/networking/connection_repository.dart:18-33`

## Code Generation

`build_runner` pipeline: `freezed`, `json_serializable`, `riverpod_generator`; `*.freezed.dart` / `*.g.dart` committed. `pubspec.yaml` `flutter: generate: true`; `l10n.yaml` + `arb_translate` generate `AppLocalizations` and machine-translate ARB files in CI.
