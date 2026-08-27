---
scope: kbRoot
path_pattern: "architecture.md"
producer: knowledge-base
type: document
description: "System architecture with diagrams, component relationships, data flows, security, and deployment for a single-project codebase."
strictness: strict
---
# System Architecture

**Project**: ELRS Mobile
**Architecture Pattern**: Feature-first layered (clean-architecture slices) + Riverpod reactive DI
**Last Updated**: 2026-08-27

## High-Level Architecture

```mermaid
graph TB
    User["RC Pilot"]
    subgraph App["ELRS Mobile - Flutter"]
        UI["Presentation: screens, go_router, theme"]
        Ctrl["Controllers and ViewModels - Riverpod"]
        Repo["Repositories and Services"]
        Assembler["Firmware Assembly Engine"]
        Core["Core: networking, discovery, storage, analytics"]
        Native["Android MethodChannel handler"]
    end
    Artifactory["ExpressLRS Artifactory"]
    Device["ELRS Device Web Server on Wi-Fi hotspot"]
    Cache["Local firmware_cache dir"]
    Prefs["SharedPreferences and SecureStorage"]
    Telemetry["Sentry and Aptabase"]
    CI["GitHub Actions"]

    User --> UI --> Ctrl --> Repo
    Ctrl --> Assembler
    Repo --> Core
    Core --> Native
    Repo -->|index.json, firmware.zip, hardware.zip| Artifactory
    Repo -->|cache archives| Cache
    Assembler -->|read base and hardware.json| Cache
    Assembler -->|serialized HTTP upload| Device
    Core -->|mDNS scan and probe| Device
    Native -->|bindProcessToWiFi, multicast lock| Device
    Ctrl -->|profiles, credentials| Prefs
    App -.errors and events.-> Telemetry
    CI -->|build APK, release| App
```

## Layers

| Layer | Purpose | Representative components |
|-------|---------|---------------------------|
| Presentation | Screens, widgets, routing, theming, responsive layout | `lib/src/features/*/presentation/*`, `lib/src/router.dart`, `lib/src/core/theme/app_theme.dart`, `lib/src/core/presentation/responsive_layout.dart`, `lib/src/app.dart` |
| Application / State | Controllers and view models orchestrating use cases and holding UI state | `flashing_controller.dart`, `flashing/state/flashing_provider.dart`, `flashing/application/firmware_patcher.dart`, `config/presentation/*_view_model.dart`, `settings_controller.dart` |
| Data | Repositories / providers for remote (Artifactory / device) and local data | `flashing/data/*`, `config/services/device_config_service.dart`, `core/networking/connection_repository.dart` |
| Domain | Immutable Freezed models and business rules | `flashing/domain/*`, `config/domain/*`, `updates/domain/*` |
| Firmware Assembly Engine | On-device ESP/STM32 binary trimming, config byte-packing, gzip | `firmware_assembler.dart`, `unified_firmware_builder.dart`, `stm32_firmware_patcher.dart`, `hardware_config_merger.dart`, `target_resolver.dart` |
| Core / Cross-cutting | Networking, discovery, connectivity, storage, analytics, logging, utils | `core/networking/*`, `core/storage/*`, `core/analytics/*`, `core/utils/*` |
| Native Platform | Android Kotlin for Wi-Fi process binding and multicast locks (iOS no-op) | `android/app/src/main/kotlin/.../MainActivity.kt` |

Dependency direction is Presentation -> Application -> Data / Domain / Core. One deliberate **inversion smell**: `core/networking/discovery_service.dart` reads `features/flashing/state` (`isFlashingProvider`) so background scanning pauses during a flash — core depends on a feature.

## Architectural Patterns

- **Feature-first modular layered architecture** — each feature is a self-contained vertical slice (`domain`, `data`, `application`/`state`, `presentation`); cross-cutting code lives in `core/`. `flashing` is the fullest slice; others (`updates`, `configurator`, `splash`, `support`) are thin.
- **Riverpod provider-based DI + reactive state** — `@riverpod` / `@Riverpod(keepAlive: true)` codegen (`*.g.dart`); `ProviderContainer` created in `main.dart`, `UncontrolledProviderScope` wraps `App`. `keepAlive` for app-lifetime singletons (discovery, analytics, target IP, `isFlashing`).
- **Local-first / offline-first pipeline** — firmware assembly and config editing happen entirely on-device so field use needs no internet after an initial cache download.
- **Platform-channel bridging** — `MethodChannel('org.expresslrs.elrs_mobile/network')` forces the app process onto the non-internet ELRS hotspot and manages multicast locks for mDNS (Android only).
- **Repository pattern for external data** — network/device access hidden behind repositories/services returning domain models.
- **Client-side request serialization (bulkhead)** — `SequentialRequestInterceptor` in `device_dio.dart` forces one-at-a-time requests to the device to protect fragile ESP8285 web servers.
- **Code-generation build pipeline** — `build_runner` with `freezed`, `json_serializable`, `riverpod_generator`; `flutter gen-l10n` + `arb_translate` for localization.

## Key Data Flows

### App startup (asynchronous bootstrap)
`main()` sets up `Logger` (piped to Sentry breadcrumbs) -> `SentryWidgetsFlutterBinding.ensureInitialized()` -> `ProviderContainer` created -> `analyticsService.init()` (Aptabase, fire-and-forget) -> `runApp(UncontrolledProviderScope -> App -> MaterialApp.router)` -> `Sentry.init()` after first frame when `SENTRY_DSN` is defined -> post-frame: `connectivityService.autoBindIfWiFi()` then `settingsController.loadSettings()`.

### Device discovery and connection (event-driven / streaming)
`connectivityService` detects Wi-Fi -> `discoveryProvider` (keepAlive stream) starts/stops a debounced mDNS scan (`nsd`) -> `NativeNetworkService.acquireMulticastLock` + `bindProcessToWiFi` (Android) -> discovered IP written to `TargetIp` -> `localDio` rebuilds with the device base URL -> `DeviceConfigService.probeDevice` polls `http://<ip>/`.

### Firmware download and caching (request/response + persistence)
Firmware Manager requests a release -> `releases_repository` / `firmware_repository` GET `https://artifactory.expresslrs.org/ExpressLRS/index.json` -> `firmware.zip` and `hardware.zip` downloaded via Dio -> `FirmwareCacheService` saves archives + targets JSON under `<AppDocuments>/firmware_cache/<version>/` -> `evictOldestVersions` enforces the max-cached limit. A version is listed only when **both** zips are present.

### Firmware assembly and flashing (synchronous pipeline)
User selects target/version/options; `flashing_controller` builds a `PatchConfiguration` -> `FirmwareAssembler` extracts the base binary from the cached `firmware.zip`, trims to the ESP `0xE9` magic -> fixed-width blocks appended to the binary tail: product name (128 B), lua name (16 B), options JSON (512 B), hardware layout JSON (2048 B); regulatory domain (FCC / EU868 / LBT) injected -> payload gzipped when the target requires it (e.g. `esp8285`) -> POSTed to the device over the serialized `localDio`. STM32 targets instead get 6-byte UID + `Uint8` domain bit-packed via `Stm32FirmwarePatcher` and have no OTA path.

### Device configuration editing (request/response)
`config_view_model` loads `RuntimeConfig` from the device via `DeviceConfigService` -> `device_editor_view_model` mutates settings; `FrequencyValidator` enforces regulatory / hardware-capability rules on the write path -> changes POSTed back; binding phrase / Wi-Fi creds persisted via `PersistenceService`. `DeviceConfigService` normalizes V3 payloads into the V4 shape (`reg_domain` -> `domain`, hoisted `settings` node, `vbind` coercion) before Freezed deserialization.

## Integration Points

| Service | Purpose | Type |
|---------|---------|------|
| ExpressLRS Artifactory (`artifactory.expresslrs.org`) | Firmware index, generic `firmware.zip`, `hardware.zip` | HTTPS REST (Dio) |
| ExpressLRS `targets.json` (GitHub raw) | Flashable target definitions; also cached and bundled as `assets/targets.json` | HTTPS GET |
| ELRS device web server (e.g. `10.0.0.1`, `elrs_rx.local`) | Read/write `hardware.json` and runtime config, upload firmware, reboot | Local HTTP (serialized Dio) |
| mDNS / DNS-SD (`nsd`) | Zero-config discovery of ELRS devices | Native service discovery |
| Android platform channel | Force Wi-Fi process binding + multicast lock | Flutter `MethodChannel` |
| Sentry | Opt-in crash/error reporting + log breadcrumbs; benign socket errors filtered, 50% sample rate; DSN via `--dart-define SENTRY_DSN` | `sentry_flutter` SDK |
| Aptabase | Privacy-friendly product analytics, opt-in via settings | `aptabase_flutter` SDK |
| Google Gemini (build-time) | Automated ARB translation via `arb_translate` | CI tooling |
| GitHub Actions | APK build + release, website deploy, ARB translation, upstream `targets.json` sync | CI/CD |

## Security & Data Protection

- **Secret storage**: `FlutterSecureStorage` (Android `encryptedSharedPreferences`) for binding phrases, Wi-Fi credentials, and the JSON-encoded flashing-profile list. `SharedPreferences` holds only non-sensitive prefs (manual IP, disclaimer acceptance, locale, migration flag). `PersistenceService.migrateIfNeeded()` performs a one-time plaintext -> secure migration tracked by `security_migration_v1_done`.
- **No auth**: the app has no accounts or backend; device access is unauthenticated local HTTP on an isolated AP.
- **Transport**: HTTPS to Artifactory/GitHub; plain HTTP to the device (the device serves no TLS).
- **Regulatory safety**: `FrequencyValidator` rejects a 2.4 GHz-capable model reporting a sub-GHz frequency (checks bit 7 of `config.modelId`), guarding against flashing an illegal frequency plan.

## Performance Considerations

- Large `targets.json` parsing is offloaded to an isolate via `compute(_parseTargets, ...)` to keep the UI responsive.
- Device probes use short (~2 s) `sendTimeout` / `receiveTimeout`; `CancelToken`s thread through device calls.
- All device HTTP is serialized (one connection at a time) — intentional throughput cap to keep the ESP8285 stable.
- `wakelock_plus` holds the screen awake during flashing; orientation locked to portrait to prevent Riverpod `autoDispose` teardown mid-flash.

## Deployment Architecture

- **Type**: Cross-platform Flutter mobile app. Flutter SDK `^3.11.0` / Dart. `pixi.toml` pins tooling env.
- **Platforms**: Android (primary — native Wi-Fi binding), iOS (native channel calls are no-ops), Web (partial, `kIsWeb` guards).
- **Version**: semantic version in `pubspec.yaml` (`1.0.43-rc1+43`).
- **Distribution**: Google Play + Apple App Store; GitHub Releases APK built by `.github/workflows/release.yml` on `main`/`development` pushes and `v*` tags.
- **Build config**: Sentry DSN injected via `--dart-define`; `flutter_launcher_icons`; assets bundle `docs/`, `assets/lua/`, `assets/targets.json`.
- **Companion**: marketing/docs website (`website/`, Astro + Starlight) deployed via `deploy-website.yml`.

## Related KB Links

- Component inventory: [modules.md](modules.md)
- Domain terminology: [concept_map.md](concept_map.md)
- Interaction semantics: [interaction-model.md](interaction-model.md)
- Code conventions: [patterns.md](patterns.md)
