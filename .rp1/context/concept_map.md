---
scope: kbRoot
path_pattern: "concept_map.md"
producer: knowledge-base
type: document
description: "Domain concepts, terminology glossary, and cross-references for a single-project codebase."
strictness: strict
---
# Domain Concepts & Terminology

**Project**: ELRS Mobile
**Domain**: ExpressLRS radio-control firmware flashing and device configuration (RC / FPV hobby)

## Core Business Concepts

### ELRS Device
A physical ExpressLRS transmitter (TX) or receiver (RX) module exposing an onboard Wi-Fi HTTP API. The primary subject the app connects to, configures, reboots, and flashes.
Implementation: `lib/src/features/config/services/device_config_service.dart`, `lib/src/features/flashing/data/device_repository.dart`.

### RuntimeConfig (+ ElrsSettings / ElrsOptions / ElrsConfig)
Freezed model of a **live device's** configuration, mirroring ELRS 4.x JSON as three nodes:
- **settings** — read-only hardware identity: module-type (RX/TX), `device_id`, `reg_domain`, band flags, versions.
- **options** — modifiable user/network prefs: `wifi-ssid` / `wifi-password`, `uid`, `wifi-on-interval`, airport / telemetry tunables.
- **config** — low-level hardware: `modelid`, serial protocol(s), `sbus-failsafe`, `pwm[]` array, hardware map.
Implementation: `lib/src/features/config/domain/runtime_config_model.dart`.

### TargetDefinition
Freezed model of a flashable hardware target, flattened from ExpressLRS `targets.json`: vendor, name, `product_code`, firmware id, platform (`esp8285` / `esp32` / `esp32-s3` / `stm32`), `device_type` (RX/TX), `frequency_type` (2.4 GHz / 900 MHz / Dual Band), `upload_methods`, `layout_file`, `overlay`, `min_version`.
Implementation: `lib/src/features/flashing/domain/target_definition.dart`, `lib/src/features/flashing/data/targets_repository.dart`.

### FlashingProfile
User-defined, named, persisted preset of flashing inputs: `bindPhrase`, `wifiSsid`, `wifiPassword`, `defaultDomain2400` / `defaultDomain900`, `wifiOnInterval`. Multiple profiles exist; one is active. Stored **encrypted** in secure storage.
Implementation: `lib/src/features/flashing/domain/flashing_profile.dart`, `lib/src/core/storage/persistence_service.dart`.

### PatchConfiguration
The set of values injected into a firmware binary at flash time: `bindPhrase`, Wi-Fi credentials, `regulatoryDomain` / `domain`, `wifiOnInterval`, `uid`. Populated from the active `FlashingProfile`.
Implementation: `lib/src/features/flashing/domain/patch_configuration.dart`.

### Unified Firmware
An ESP firmware binary assembled locally by appending fixed-size sections to a trimmed base binary: product name (128 B) + lua name (16 B) + options JSON (512 B) + hardware layout JSON (2048 B). Built when platform, product name, lua name, uid, and hardware layout are all present.
Implementation: `lib/src/features/flashing/utils/firmware_assembler.dart` (sole implementation — the divergent duplicate `unified_firmware_builder.dart`, which used a naive/less-correct firmware-trimming algorithm, was deleted as dead code).

### Hardware Layout
Pin/board definition JSON. The base layout is extracted from the release's `hardware.zip` by `layout_file` name, then shallow-merged with the target's `overlay` via `HardwareConfigMerger`.
Implementation: `lib/src/features/flashing/utils/target_resolver.dart`, `lib/src/core/storage/firmware_cache_service.dart`.

### Firmware Cache
On-device (app documents directory) store of downloaded `firmware.zip`, `hardware.zip`, and targets JSON per version. A version is listed only when **both** zips exist; supports oldest-first eviction, size reporting, and a `latest` fallback for targets JSON.
Implementation: `lib/src/core/storage/firmware_cache_service.dart`.

### Legacy Config Reconstruction
For firmware older than 3.1.0 (which predates the unified `/config` endpoint and returns 404), `DeviceConfigService._fetchLegacyConfig` reconstructs a `RuntimeConfig` from `/target` (`product_name`, `version`, `target`, `reg_domain`) plus a best-effort merge of `/mode.json` (`modelid`, `force-tlm`, `uid`) for firmware where that endpoint still exists (removed ~3.2.x). Exists so `RuntimeConfigX.effectiveProductName` can feed the Target Mismatch Guard real device data instead of leaving very old devices stuck "disconnected" — flashing/downloads remain gated to firmware `>= 3.3.0` regardless.
Implementation: `lib/src/features/config/services/device_config_service.dart`.

## Technical Concepts

### UID / Binding Phrase
A 6-byte identifier bonding a TX and RX. Derived from a binding phrase via MD5 of the compiler-literal string `-DMY_BINDING_PHRASE="<phrase>"` (first 6 bytes), matching ELRS `phrase.js`. An empty phrase yields `[0,0,0,0,0,0]`.
Implementation: `lib/src/core/utils/binding_phrase_utils.dart`.

### Regulatory Domain
Region / frequency-plan selector. Only the 900 MHz label set survives in `ElrsMappings` as of this change range: `AU915` / `FCC915` / `EU868` / `IN866` / `AU433` / `EU433` / `US433` / `US433-Wide`. Represented as an integer index (`options.domain` / `settings.domain`) or a V3/V4 string (`reg_domain`, `reg_domain_low`/`high`). The parallel 2.4 GHz label map (`ISM_2400`/`EU_CE_2400`) and the `getDomainLabel`/`getMapping` helpers were deleted as dead code — nothing in the codebase referenced them.
Implementation: `lib/src/features/config/domain/elrs_mappings.dart` (now a single `domains900` constant).

### Frequency Band
Whether a device operates at 900 MHz or 2400 MHz. Resolved heuristically from product name / target / module-type strings, falling back to **bit 7 of `config.modelId`** as the authoritative hardware capability flag (same source the device WebUI uses).
Implementation: `lib/src/features/config/utils/frequency_validator.dart`, `runtime_config_model.dart`.

### Firmware Release / Version
An ExpressLRS version string (`>= 3.3.0`, incl. 4.x). Enumerated from the Artifactory `index.json` (version -> commit hash); each downloadable as `firmware.zip` and `hardware.zip` per commit hash.
Implementation: `lib/src/features/flashing/data/releases_repository.dart`.

### Model Match / Model ID
ELRS feature binding an RX to a specific transmitter model id (0–63). `config.modelid` also carries the 2.4 GHz capability flag in bit 7. Toggled via `POST /config {modelid, modelMatch}`.
Implementation: `lib/src/features/flashing/data/device_repository.dart`.

### PWM Mapping
Per-output-pin assignment of an input RC channel plus an output mode (50 Hz–400 Hz, DSHOT300, On/Off, Serial TX/RX). Sent as the `config.pwm` array indexed by pin. The `pwmModes` label map that named each mode by index was deleted from `ElrsMappings` as dead code (unreferenced); the underlying `config.pwm` array field on `RuntimeConfig` is unaffected and still round-trips normally.
Implementation: `lib/src/features/config/domain/runtime_config_model.dart` (`config.pwm` field).

## New / Refined Concepts (2026-09-21)

- **Legacy Firmware Fallback Chain** — a probe/config-fetch fallback ladder for pre-3.1.0 devices: `probeDeviceHead` tries `/hardware.json` (unified firmware only) then falls back to the universal `/` probe; `fetchConfig` tries `/config` (added 3.1.0) then falls back to `_fetchLegacyConfig` via `/target` + optional `/mode.json` on a 404.
- **Target Mismatch Guard** — compares a device's actual effective product name/target against the user's selected flashing target and blocks/flags flashing on mismatch; the legacy-config path exists specifically to feed this guard real data for old firmware instead of leaving it unresolved.
- **Direct Force-Confirm** (refined) — on a mismatch override, ExpressLRS firmware (3.1.0-4.1.0) retains the mismatched firmware already sitting in the device's OTA write buffer from the initial `/update` attempt, so `FlashingController` now calls `confirmForceUpdate()` directly first with no re-upload; only on failure (e.g. dropped connection) does it fall back to re-uploading and confirming again. Supersedes the prior assumption that the buffer always needed a re-upload.
- **Unified Firmware Version Floor** (confirmed, wording tightened) — versions before 3.3.0 lack unified firmware support and are excluded from `ReleasesRepository`'s downloadable list (`major < 3`, or `major == 3` with `minor < 3`); STM32 legacy targets remain compatible only with 3.3.x (not 4.x+).

## New / Refined Concepts (2026-09-22)

- **Expected Reboot Socket Drop (extracted helper)** — `isExpectedRebootSocketDrop(DioException)`, a pure predicate matching connection-abort/reset/broken-pipe/refused error text following `/update`, `/forceupdate`, or `/reboot`. Extracted out of `device_repository.dart` into a standalone `core/networking/expected_reboot_drop.dart` helper during a dead-code cleanup pass (commit `6adc375`), replacing two independently-maintained copies that had diverged (one omitted `ECONNREFUSED`, causing some successful flashes to be misreported as failures). Currently consumed only by `DeviceRepository.flashFirmware`/`confirmForceUpdate` — `DeviceConfigService` no longer has a `reboot` method to call it from.
- **Dead-code elimination pass** (commit `6adc375`, "chore: remove dead code, orphaned files, and unwired vendored package") — removed entire unused subsystems and unreferenced lookup tables in one sweep: the app self-update feature (`lib/src/features/updates/`), `BitList` (`lib/src/bit_list.dart`), the orphaned `discovery_provider.dart`(`.g.dart`), `DeviceEditorViewModel`, `ConnectionStatusBadge`, `unified_firmware_builder.dart`, three unused barrel `index.dart` files, the unwired vendored `packages/ip_address_keypad/`, ~290 combined dead-method lines from `device_config_service.dart`/`device_repository.dart`/`config_view_model.dart`, and five of six lookup maps plus two helper methods from `ElrsMappings` (kept only `domains900`). ~1,150 net lines removed.
- **Truthful, phase-accurate flash progress** — the flash-upload lifecycle (`FlashingController.FlashingStatus`) now distinguishes `locating` (checking local cache) / `unpacking` (reading from cache — the normal offline path this app is built for) / `downloading` (rare network fallback only) / `building` (renamed from `patching`) / `uploading` (byte progress scaled into a fixed 66%-95% band) / `finalizing` (new — an indeterminate progress state entered once all bytes are sent but before the device confirms, since the device's flash-write-and-reboot afterward has no progress signal of its own). Closes a real bug where `DeviceRepository.flashFirmware`'s `onSendProgress` callback was accepted and documented but silently never invoked.

## Key Relationships

| From | Relationship | To |
|------|--------------|-----|
| `TargetsRepository` | flattens nested `targets.json` into | `TargetDefinition` list |
| `FlashingController` | invokes for download / extraction | `FirmwareRepository` |
| `FirmwareRepository` | resolves version -> commit hash via | Artifactory `index.json` |
| `DeviceRepository` | uses to build unified firmware / trim | `FirmwareAssembler` |
| `DeviceRepository` | derives UID before `POST /config` via | `BindingPhraseUtils` |
| `DeviceRepository` | classifies post-reboot `DioException`s via | `isExpectedRebootSocketDrop` (`expected_reboot_drop.dart`) |
| `PatchConfiguration` | populated from | active `FlashingProfile` |
| `PersistenceService` | serializes to `FlutterSecureStorage` | `FlashingProfile` list |
| `DiscoveryService` | emits discovered IP to | `TargetIp` notifier |
| `DeviceConfigService` | normalizes raw `/config` (V3->V4) into | `RuntimeConfig` |
| `RuntimeConfigX` | delegates write-path frequency checks to | `FrequencyValidator` |
| `FirmwareCacheService` | merges base layout + overlay via | `HardwareConfigMerger` |
| `TargetsRepository` / `ReleasesRepository` | fall back to | `FirmwareCacheService` (then bundled asset) |

## Recurring Domain Patterns

- **Tiered fallback (network -> cache -> bundled asset)** — targets and release-version retrieval.
- **V3-to-V4 normalization adapter** — `DeviceConfigService` hoists identity keys into a synthetic `settings` map, coerces `reg_domain` / `vbind` before deserialization.
- **Expected-error-as-success** — `DioException`s matching known connection-drop fragments after `/update`, `/forceupdate`, or `/reboot` are swallowed because the device reboots and severs Wi-Fi. Now implemented by the standalone `isExpectedRebootSocketDrop` predicate in `core/networking/expected_reboot_drop.dart` rather than inline, duplicated logic.
- **Binary section-append assembly** — fixed-size padded blocks appended to trimmed firmware.
- **Serialized async operation queue** — `DiscoveryService._runOperation` chains start/stop/restart to prevent UDP 5353 rebind races.
- **One-time data migration with guard flag** — plaintext secrets -> secure storage, tracked by `security_migration_v1_done`.
- **Effective-value coalescing getters** — `RuntimeConfigX.effectiveProductName` / `effectiveVersion` / `effectiveTarget` walk a priority chain across firmware versions with a literal fallback.
- **Dead-code elimination pass** — periodic cleanup passes remove unreferenced entities entirely (`BitList`, `discovery_provider.dart`, the `updates` feature, most of `ElrsMappings`) rather than deprecating in place; when reconciling this KB, re-check whether a documented concept still has any implementation before repeating it.

## Bounded Contexts

| Context | Scope | Owns | Does not own |
|---------|-------|------|--------------|
| Networking / Connectivity | `lib/src/core/networking` | device presence detection, IP resolution, split local-vs-internet Dio clients | config semantics, flashing |
| Storage / Persistence | `lib/src/core/storage` | all local disk + key-value persistence, secret migration, offline targets JSON | device / network API calls |
| Flashing | `lib/src/features/flashing` | firmware acquisition, local patch/assembly, `/update` upload flow | live config editing |
| Config / Device Editing | `lib/src/features/config` | live-device config model, integer<->label mapping (now minimal: `domains900` only), read HTTP contract | firmware binaries, config writes/reboot (moved to the config feature's embedded-WebView surface) |

## Terminology Glossary

- **ELRS / ExpressLRS** — open-source long-range RC link firmware and hardware ecosystem this app targets.
- **Binding Phrase** — human-readable secret hashed (MD5) into a 6-byte UID pairing a TX and RX. Aliases: bind phrase, `bindPhrase`.
- **UID** — 6-byte unique identifier derived from the binding phrase; injected into firmware or posted to `/config`.
- **Target** — a specific flashable hardware model, e.g. `Unified_ESP32_2400_RX`. Alias: firmware target.
- **Unified Firmware** — ESP firmware with appended fixed-size config sections, assembled on-device rather than compiled per-target.
- **Regulatory Domain** — legal frequency plan for a region (e.g. `FCC915`, `EU868`, `ISM_2400`). Aliases: `reg_domain`, `domain`.
- **LBT vs FCC** — firmware release zip subfolders: LBT (Listen-Before-Talk, EU) and FCC (Americas); selected by the `isLbt` flag during extraction.
- **Module Type** — device role reported by firmware: RX (receiver) or TX (transmitter). Aliases: `module-type`, `device_type`.
- **V3 / V4 firmware** — ExpressLRS config-schema generations; V3 nests identity fields in `config`, V4 splits them into a `settings` node. The app normalizes V3 to V4 shape.
- **Artifactory** — `artifactory.expresslrs.org`, the CI artifact host; `index.json` maps version tags to commit hashes.
- **targets.json** — ExpressLRS repo file (nested vendor -> category -> device) describing every flashable target; fetched from GitHub raw, cached, or bundled as an asset.
- **hardware.zip / layout_file** — per-release archive of board pin layouts; `layout_file` names the entry merged with a target overlay.
- **WYSIWIS** — "What You See Is What Is Sent" — UI-visible bit/field values map exactly to the device payload.
- **Expected reboot socket drop** — a `DioException` (connection abort/reset/broken pipe/refused) following a successful `/update`, `/forceupdate`, or `/reboot`, treated as success. Implemented by the standalone `isExpectedRebootSocketDrop` predicate (`core/networking/expected_reboot_drop.dart`).
- **AirPort** — ELRS serial-protocol mode for transparent serial-over-RF bridging; gated by `options.is-airport` and `airport-uart-baud`. Note: the `serialProtocols` label map that named this mode by index was deleted from `ElrsMappings` as dead code; the underlying `options` fields remain in `RuntimeConfig` and are unaffected.
- **Model Match** — RX-side filter accepting only a transmitter broadcasting a matching model id (0–63). Aliases: `modelMatch`, `modelid`.
- **wifi-on-interval** — seconds after boot the device keeps its Wi-Fi AP active before disabling it; a flashing/config parameter.
- **freqIndex** — domain-list index within the active band (not a band selector); defaults to 0 regardless of band.
- **Expert Mode** — opt-in settings toggle revealing STM32 targets, raw binary download, Lua export, and debug reporting.
- **Secure Storage Cipher Migration** — `flutter_secure_storage` upgraded `9.x -> 10.x`; `PersistenceService`'s `AndroidOptions` dropped the explicit `encryptedSharedPreferences: true` flag (v10 changes Android's default cipher/storage backend), part of an in-progress cipher migration alongside the existing plaintext-to-secure-storage one-time migration.

## Cross-References

- Component boundaries and providers: [modules.md](modules.md)
- Data flows and integration points: [architecture.md](architecture.md)
- User-visible states for these concepts: [interaction-model.md](interaction-model.md)
