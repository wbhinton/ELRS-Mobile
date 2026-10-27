---
title: Technical Specification
slug: technical_spec
sidebar:
  order: 5
---

Reference for the interfaces, data models and storage ELRS Mobile uses. For how the pieces fit together, see [Technical Architecture](/technical_architecture).

## Device HTTP endpoints

ExpressLRS devices serve a small HTTP API on their Wi-Fi interface (`10.0.0.1` on the device's own hotspot). All requests from the app go through one serialized client, one request at a time.

| Method | Endpoint | Used for | Firmware |
| :--- | :--- | :--- | :--- |
| `GET` | `/` | Presence probe during discovery | All |
| `GET` | `/hardware.json` | Quick identity probe | 3.2 and newer |
| `GET` | `/config` | Device configuration (`RuntimeConfig`) | 3.1 and newer |
| `GET` | `/target` | Identity fallback: product name, version, target, domain | Older than 3.1 |
| `GET` | `/mode.json` | Best-effort fallback: model id, UID | Older than 3.1, where present |
| `POST` | `/update` | Firmware upload (multipart); `?force=1` skips the device's target check | All supported |
| `POST` | `/forceupdate` | `action=confirm` commits an image the device buffered after a target mismatch | All supported |

`/update` and `/forceupdate` reply with JSON whose `status` is `ok`, `mismatch` or an error. The device sends its reply and then reboots. The app treats only `ok` as success; see [Technical Architecture](/technical_architecture) for how dropped connections are classified.

Device settings are edited through the device's own web interface, shown in the app's Device Config screen, so the app sends no configuration writes of its own.

## Device configuration model

`RuntimeConfig` mirrors the ExpressLRS 4.x `/config` structure, with three nodes:

- `settings`: read-only identity, such as module type (RX or TX), product name, target, version and regulatory domain.
- `options`: user and network options, such as UID, Wi-Fi SSID and password, Wi-Fi auto-on interval and the sub-GHz domain.
- `config`: hardware configuration, such as model id, serial protocol and the PWM output array.

ExpressLRS 3.x returns a different shape. The app normalizes it to the 4.x layout before parsing, for example moving identity fields into `settings` and renaming `reg_domain` to `domain`. Pre-3.1 devices are reconstructed from `/target` and `/mode.json`.

The device's chip family is derived from the target it reports and compared with the selected firmware's platform before flashing.

## Firmware options block

When building ESP firmware, the app appends an options JSON block (up to 512 bytes) to the binary. Its fields include:

| Field | Source |
| :--- | :--- |
| `uid` | First 6 bytes of `MD5('-DMY_BINDING_PHRASE="<phrase>"')`; omitted for an empty phrase |
| `wifi-ssid`, `wifi-password` | Home Wi-Fi network and password from the active profile |
| `wifi-on-interval` | Seconds before Wi-Fi starts automatically (default 60) |
| `domain` | Sub-GHz regulatory domain (900 MHz and dual-band targets) |
| `flash-discriminator` | Value derived from the build time, identifying this build |

The JSON is written without whitespace. It is functionally identical to the ExpressLRS Configurator's output, which adds spaces, but not byte-identical; see [Firmware Validation](/firmware-validation).

## Regulatory domains

Sub-GHz domains use these indices (`ElrsMappings.domains900`):

| Index | Label | Region |
| :--- | :--- | :--- |
| 0 | AU915 | Australia and New Zealand, 915 MHz |
| 1 | FCC915 | North America, 915 MHz |
| 2 | EU868 | Europe, 868 MHz |
| 3 | IN866 | India, 866 MHz |
| 4 | AU433 | Australia, 433 MHz |
| 5 | EU433 | Europe, 433 MHz |
| 6 | US433 | North America, 433 MHz |
| 7 | US433-Wide | North America, wide 433 MHz |

2.4 GHz targets have two options, ISM (2.4 GHz) and EU CE (2.4 GHz LBT). The choice selects the FCC or LBT build of the firmware rather than writing a field.

## Flashing profile

| Field | Type | Default |
| :--- | :--- | :--- |
| `name` | string | |
| `bindPhrase` | string | empty |
| `wifiSsid`, `wifiPassword` | string | empty |
| `defaultDomain2400` | int | 0 (ISM) |
| `defaultDomain900` | int | 1 (FCC915) |
| `wifiOnInterval` | int (seconds) | 60 |

## Persistence

| Store | Holds |
| :--- | :--- |
| `FlutterSecureStorage` (OS-encrypted) | Flashing profiles, active profile, binding phrase, Wi-Fi network and password |
| `SharedPreferences` | Non-sensitive preferences: manual IP, disclaimer acceptance, Wi-Fi auto-on interval, language, Expert Mode, analytics opt-in, cache limit, update-check timestamps and skipped version, migration flags |
| App documents directory | Firmware cache: `firmware.zip` and `hardware.zip` per version, plus cached `targets.json` |

Secure storage has been through two format upgrades. Data written by v1.0.44 or newer carries over; updating directly from v1.0.43 or older can't, and the app tells the user once instead of silently showing empty profiles.

## External services

| Service | Purpose |
| :--- | :--- |
| `artifactory.expresslrs.org` | Firmware index (`index.json`), `firmware.zip` and `hardware.zip` |
| `raw.githubusercontent.com` | Latest ExpressLRS `targets.json` |
| `cdn.elrsmobile.com/latest.json` | Release information for the direct-download APK's update check |
| Sentry | Crash reporting and optional debug reports (enabled only when built with `SENTRY_DSN`) |
| Aptabase | Anonymous usage analytics (can be turned off in Settings) |
