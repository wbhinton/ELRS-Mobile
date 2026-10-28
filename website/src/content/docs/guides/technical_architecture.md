---
title: Technical Architecture
slug: technical_architecture
sidebar:
  order: 6
---

ELRS Mobile is not a wrapper around the web flasher. It is a native Dart implementation of the ExpressLRS firmware build and flashing pipeline, ported from the official Web Flasher, so that the whole process runs on the phone without internet.

## Firmware caching

Flashing offline depends on having everything on the phone in advance.

- **Releases.** The Firmware Manager reads the ExpressLRS Artifactory index (`artifactory.expresslrs.org/ExpressLRS/index.json`), which maps each version to a build. Only versions 3.3.0 and newer are offered, the first with unified firmware.
- **Archives.** Each version is downloaded as two archives: `firmware.zip` (the generic unified binaries) and `hardware.zip` (board layouts). `FirmwareCacheService` stores them under the app's documents directory, per version. A version counts as cached only when both archives are present. When the cache limit is reached, the oldest versions are evicted first.
- **Targets.** `targets.json`, the ExpressLRS list of every device, is bundled with the app (`assets/targets.json`, synced from upstream by a GitHub Action), refreshed from GitHub when online, and cached. Loading falls back from network to cache to the bundled copy, and the large file is parsed on a background isolate.

## Unified firmware assembly

ESP targets don't need a compiler. The app builds the final binary from the generic firmware plus your settings, in `FirmwareAssembler`:

1. Extract the generic firmware for the target from the cached `firmware.zip`. For 2.4 GHz targets the regulatory choice selects the FCC or LBT (EU) build.
2. Trim the trailing padding by locating the ESP image header (`0xE9` magic byte).
3. Resolve the hardware layout: take the base layout named by the target's `layout_file` from `hardware.zip`, then merge the target's `overlay` on top.
4. Append four fixed-width blocks: product name (128 bytes), Lua name (16 bytes), options JSON (512 bytes, including the UID derived from your binding phrase, Wi-Fi credentials, the sub-GHz regulatory domain, and the Wi-Fi auto-on interval), and hardware layout JSON (2048 bytes).
5. Gzip the result when the platform expects compressed uploads (ESP8285).

The UID is derived the same way as ExpressLRS's `phrase.js`: the first six bytes of the MD5 of `-DMY_BINDING_PHRASE="<phrase>"`.

**STM32 targets** (Expert Mode, ExpressLRS 3.3.x only) take a different path: `Stm32FirmwarePatcher` writes the 6-byte UID and the regulatory domain directly into the binary. STM32 hardware has no Wi-Fi updates, so the result is saved for flashing from a PC.

## Flashing pipeline

`FlashingController` runs each flash as a sequence of checks and then the upload.

**Pre-flight checks**

1. **Chip check.** The device's chip family (from the target it reports) is compared with the selected target's platform. A mismatch is blocked outright: the firmware can't boot, and the device would reject it even when forced.
2. **Binding phrase check.** An empty phrase asks the user to confirm.
3. **Target check.** The device's product name is compared with the selected target's product name. Products share unified builds, so the comparison is by product, not platform. A mismatch asks the user to confirm with **Force Flash**.

**Build and upload**

The progress bar reports real phases: *locating* and *unpacking* the cached firmware (the normal offline path), *downloading* only if a file is missing, *building*, *uploading* (byte progress), and *finalizing* (an indeterminate state while the device writes flash and restarts, which reports no progress of its own).

During a flash the screen is kept awake, orientation is locked, and background discovery and heartbeat polling pause. The firmware is posted to the device's `/update` endpoint with an explicit `Content-Length`. With **Force Flash**, the upload adds the device's `force` argument; if the device still reports a mismatch, the app commits the already-buffered image through `/forceupdate`.

**Result**

The device replies with a JSON status and only then reboots, so the app reports success only when that reply says `ok`. A connection lost during the upload is a failure. A connection lost after the last byte was sent but before any reply is ambiguous: the device may have lost power or crashed while writing, or the reply may have been lost on a weak link. That case raises a distinct *unconfirmed* result, shown as a warning, so it is never reported as a successful flash. The same rule applies to `/forceupdate`. Replies that aren't status JSON (very old firmware) are treated as success.

## Discovery and connectivity

- **Discovery.** `DiscoveryService` scans with mDNS while the phone is on Wi-Fi. Start, stop and restart operations are serialized so the UDP 5353 socket is never rebound mid-scan. Until a device is found, the app also probes `elrs_rx.local`, `elrs_tx.local`, `10.0.0.1` and any manual IP the user entered.
- **Connection.** Once found, a heartbeat keeps the Dashboard status live, with an aggressive reconnect window after a flash while the device reboots.
- **Older firmware.** Configuration is read from `/config` (firmware 3.1 and newer). Older devices are identified through `/target` and, where present, `/mode.json`, so they can still be matched and updated.
- **Request serialization.** All device HTTP goes through one Dio client whose interceptor sends requests strictly one at a time. ESP8285 web servers can crash under concurrent requests.

### Native network binding (Android)

Android routes traffic away from Wi-Fi networks without internet access, which would send requests for `10.0.0.1` over mobile data. `NativeNetworkService` calls a platform `MethodChannel` that binds the app process to the Wi-Fi network and holds a multicast lock for mDNS. The binding is released while firmware is downloaded and restored before upload. iOS has no equivalent API, so these calls do nothing there.

## Device configuration

Editing device settings is delegated to the device's own web interface, shown in a WebView locked to the device's address. The app doesn't reimplement the ExpressLRS settings UI, so new firmware options appear without an app update.

## App updates (direct-download builds)

Builds made with `DISTRIBUTION=direct` check `cdn.elrsmobile.com/latest.json` at most once a day, or on demand from Settings. The release workflow publishes that file alongside each APK. A newer version opens a dialog to download it, skip that version, or be reminded later. Store builds never check: Google Play and the App Store handle their updates.
