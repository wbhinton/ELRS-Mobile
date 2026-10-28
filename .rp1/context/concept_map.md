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
**Updated**: 2026-10-27 (commit 3e8eab5, app v1.0.45+111)

## Core Business Concepts

### ELRS Device
A physical ExpressLRS transmitter (TX) or receiver (RX) exposing an onboard Wi-Fi HTTP API. The subject the app discovers, identifies, flashes, and (via its own web UI) configures.
Implementation: `lib/src/features/config/services/device_config_service.dart`, `lib/src/features/flashing/data/device_repository.dart`.

### RuntimeConfig (+ settings / options / config)
Freezed model of a live device's configuration mirroring ELRS 4.x `/config`: **settings** (read-only identity: module type, product name, target, version, domain), **options** (UID, Wi-Fi SSID/password, wifi-on-interval, domain, airport/telemetry tunables), **config** (modelid, serial protocol, `pwm[]`). V3 payloads are normalized to this shape. `RuntimeConfigX.effectiveProductName/Version/Target` coalesce across firmware generations.
Implementation: `lib/src/features/config/domain/runtime_config_model.dart`.

### TargetDefinition
A flashable hardware target flattened from ExpressLRS `targets.json`: vendor, name, `product_name`, firmware id, platform (`esp8285`/`esp32`/`esp32-c3`/`esp32-s3`/`stm32`), device type, frequency type, `upload_methods`, `layout_file`, `overlay`, `min_version`. The same bundled file (`assets/targets.json`) also generates the website's supported-hardware list.
Implementation: `lib/src/features/flashing/domain/target_definition.dart`, `lib/src/features/flashing/data/targets_repository.dart`, `website/src/data/hardware.ts`.

### FlashingProfile / PatchConfiguration
**FlashingProfile**: named, persisted preset (`bindPhrase`, `wifiSsid`, `wifiPassword`, `defaultDomain2400`=0, `defaultDomain900`=1, `wifiOnInterval`=60); one active; stored in secure storage. **PatchConfiguration**: the values injected into a binary at flash time, populated from the active profile.
Implementation: `lib/src/features/flashing/domain/flashing_profile.dart`, `patch_configuration.dart`, `lib/src/core/storage/persistence_service.dart`.

### Unified Firmware
ESP firmware assembled on-device: base binary trimmed at the `0xE9` image magic, then four fixed-width blocks appended: product name (128 B), Lua name (16 B), options JSON (512 B: `flash-discriminator`, `wifi-on-interval`, `uid` if non-zero, `wifi-ssid`/`wifi-password` if set, `domain` for 900 MHz/dual-band only, plus TX/RX tunables), hardware layout JSON (2048 B). Gzipped for ESP8285. `FirmwareAssembler` is the sole ESP builder; STM32 uses `Stm32FirmwarePatcher` (UID + domain bit-packed, no OTA, 3.3.x only).
Implementation: `lib/src/features/flashing/utils/firmware_assembler.dart`, `stm32_firmware_patcher.dart`, `application/firmware_patcher.dart`.

### Hardware Layout
Pin/board JSON taken from a release's `hardware.zip` by `layout_file`, shallow-merged with the target `overlay`.
Implementation: `lib/src/features/flashing/utils/target_resolver.dart`, `hardware_config_merger.dart`.

### Firmware Cache
On-disk `firmware.zip` + `hardware.zip` (+ targets JSON) per version under app documents; a version counts as cached only when both zips exist; oldest-first eviction against `maxCachedVersions` (default 2).
Implementation: `lib/src/core/storage/firmware_cache_service.dart`.

### FlashError (typed outcome)
Dart 3 sealed hierarchy with a stable analytics `code` and optional untranslated `detail`: `NoTargetSelected`, `NoVersionSelected`, `NoDeviceConnected`, `NoBindPhrase` (confirm prompt), `ChipMismatch(deviceChip, targetChip)` (hard block), `OfflineMissingFiles(duringFlash)`, `FlashFailed`, `FlashUnconfirmed` (amber), `DownloadFailed`. Localized by `flash_error_text.dart`. Firmware Manager has a parallel `FirmwareManagerError` kind enum (loadFailed, onDeviceHotspot, cacheFull, serverUnreachable, downloadInterrupted, downloadFailed, deleteFailed).
Implementation: `lib/src/features/flashing/domain/flash_error.dart`, `presentation/flash_error_text.dart`, `features/firmware_manager/presentation/firmware_manager_error.dart`.

### AppRelease / Direct-Distribution Update
`AppRelease{version, versionCode, downloadUrl}` parsed from `https://cdn.elrsmobile.com/latest.json` (rejects malformed/non-https; prefers the versioned `url` over `latest_url` to dodge edge caching). Only in builds made with `--dart-define=DISTRIBUTION=direct` (`kIsDirectDistribution`); checked at most every 24 h or on demand; skip-version / later.
Implementation: `lib/src/features/app_update/`.

### Verified Hardware
A target is "verified" after at least one successful flash in analytics. `website/scripts/build_verified.py` turns the analytics CSV export into `website/src/data/verified.json` (`asOf`, `totalSuccessfulFlashes`, `targets[]` of `product_name`s; `Unknown` excluded from targets but counted in the total).

## Rules

- **Chip Guard**: `chipFamilyOf(device effectiveTarget)` vs `chipFamilyOf(target.platform ?? firmware)`; mismatch is a hard block (no Force Flash). Skipped when either side is unknown (legacy per-product names). ESP8266 maps to esp8285. (`utils/chip_family.dart`, commit daa9792)
- **Target Mismatch Guard**: compares device product name with the selected target's `product_name` (unified builds are shared across products, so platform is not enough); skipped when the device reports the generic "ELRS Device"; forceable.
- **Force Flash**: re-upload via `POST /update?force=1`; only if the device still replies `mismatch` call `confirmForceUpdate()` (`POST /forceupdate action=confirm`). Supersedes the older "confirm buffered image first" flow (commit cf39001).
- **Flash success semantics (confirm-by-reply)**: success only when the device's JSON `status == "ok"` (non-status replies from very old firmware count as success). Drop mid-upload = failure. Drop after the last byte with no reply = `FlashUnconfirmedException` → `FlashUnconfirmed`. Same for `/forceupdate`. `isExpectedRebootSocketDrop` only classifies the drop; it no longer implies success.
- **Firmware floor**: only versions ≥ 3.3.0 are listed/downloadable (unified firmware). Older devices (≥ ~3.0) can still be identified via legacy endpoints and updated.
- **UID / Binding Phrase**: first 6 bytes of MD5(`-DMY_BINDING_PHRASE="<phrase>"`) (ELRS `phrase.js`); empty phrase yields zeros, which are omitted from options.
- **Regulatory domain**: sub-GHz uses `ElrsMappings.domains900` indices (0 AU915, 1 FCC915, 2 EU868, 3 IN866, 4 AU433, 5 EU433, 6 US433, 7 US433-Wide) written as `options.domain`; 2.4 GHz (ISM vs EU CE LBT) selects the FCC or LBT build instead of writing a field.
- **Frequency band**: heuristics on product/target/module strings, with bit 7 of `config.modelId` authoritative; `FrequencyValidator` guards against illegal plans.

## Legacy Config Reconstruction
For firmware < 3.1 (no `/config`, 404), `DeviceConfigService._fetchLegacyConfig` rebuilds a `RuntimeConfig` from `/target` plus best-effort `/mode.json`; `probeDeviceHead` falls back from `/hardware.json` (3.2+) to `/`. Feeds the mismatch guard with real data for old devices.

## Flash Progress Lifecycle
`FlashingStatus`: idle → locating → unpacking (offline cache read, the normal path) → downloading (rare fallback) → building → uploading (scaled 66–95 %) → finalizing (indeterminate while the device writes/reboots) → success | error | mismatch (+ downloadSuccess for Expert binary saves).

## Key Relationships

| From | Relationship | To |
|------|--------------|-----|
| `TargetsRepository` | flattens | `targets.json` → `TargetDefinition` list |
| `FlashingController` | guards with | `chipFamilyOf`, mismatch check, bind-phrase check |
| `FlashingController` | emits | `FlashError` (rendered by `flash_error_text.dart`; `code` = analytics `errorType`) |
| `FlashingController` | calls conditionally | `confirmForceUpdate()` after a forced upload still reports mismatch |
| `DeviceRepository` | builds via | `FirmwareAssembler`; classifies drops via `isExpectedRebootSocketDrop` |
| `FirmwareRepository` | resolves version via | Artifactory `index.json` |
| `PatchConfiguration` | populated from | active `FlashingProfile` |
| `PersistenceService` | stores in secure storage | profiles, active profile id, bind phrase, Wi-Fi creds |
| `DeviceConfigService` | normalizes into | `RuntimeConfig` |
| `AppUpdateService` | parses | `latest.json` → `AppRelease` |
| `build_verified.py` + `hardware.ts` | join | analytics export + `assets/targets.json` → website hardware list |

## Bounded Contexts

| Context | Scope | Owns |
|---------|-------|------|
| Networking | `lib/src/core/networking` | discovery, IP resolution, serialized device Dio, reboot-drop predicate, Android Wi-Fi binding |
| Storage | `lib/src/core/storage` | prefs, secure storage + migrations, firmware cache |
| Flashing | `lib/src/features/flashing` | targets, firmware acquisition, assembly, upload, guards, typed errors |
| Config | `lib/src/features/config` (+ `configurator` WebView) | RuntimeConfig read, legacy fallback, domain labels, frequency validation (writes only via device web UI) |
| Firmware Manager | `lib/src/features/firmware_manager` | cached versions, typed errors |
| App Update | `lib/src/features/app_update` | direct-build release check |
| Website / Distribution | `website/`, `.github/workflows` | marketing/docs site, verified hardware, release + CDN mirror |

## Terminology Glossary

- **ELRS / ExpressLRS**: open-source long-range RC link ecosystem.
- **Binding Phrase** (bind phrase, `bindPhrase`): secret hashed into the 6-byte UID.
- **Target**: flashable hardware model, e.g. `Unified_ESP32_2400_RX`.
- **Unified Firmware**: ESP firmware with appended config blocks, assembled on-device.
- **LBT vs FCC**: EU Listen-Before-Talk vs Americas firmware folders for 2.4 GHz, chosen by the regulatory selection.
- **V3 / V4 firmware**: config-schema generations; V3 normalized to V4.
- **Artifactory**: `artifactory.expresslrs.org`, firmware index + archives.
- **targets.json**: upstream list of every target; bundled as `assets/targets.json` (synced by `update_targets.yml`), refreshed from GitHub, cached. The stale repo-root copy was deleted.
- **Expected reboot socket drop**: abort/reset/broken-pipe/refused after `/update` or `/forceupdate`; classification only.
- **FlashUnconfirmed**: full image sent, no reply; outcome unknown, amber warning.
- **Chip mismatch**: wrong chip family; hard block.
- **Expert Mode**: reveals STM32 targets, Download Binary, Lua export, debug report.
- **DISTRIBUTION=direct / kIsDirectDistribution**: build flag for the sideload APK; enables update checks.
- **latest.json**: CDN release manifest published by `publish-apk-r2.yml`; `ELRS-Mobile-latest.apk` is a public link (given to RadioMaster) that must not move.
- **Saved Settings Reset**: one-time notice when the secure-storage v11 upgrade can't carry data written by ≤ 1.0.43 (`secure_storage_data_lost` flag).
- **Share Analytics**: Aptabase opt-out toggle, default on. Sentry is separate.
- **Model Match / modelid**: RX accepts only a TX with matching model id (0–63); bit 7 also flags 2.4 GHz.
- **wifi-on-interval**: seconds after boot before the device starts its Wi-Fi AP.
- **WYSIWIS**: UI values map exactly to the device payload.

## Cross-References

- Component boundaries: [modules.md](modules.md)
- Data flows and integrations: [architecture.md](architecture.md)
- User-visible states: [interaction-model.md](interaction-model.md)
- Conventions: [patterns.md](patterns.md)
