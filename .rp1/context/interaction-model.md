---
scope: kbRoot
path_pattern: "interaction-model.md"
producer: knowledge-base
type: document
description: "Cross-surface interaction semantics, UX principles, user-visible states, and accessibility constraints for a single-project codebase."
strictness: strict
---
# ELRS Mobile - Interaction Model

**Project**: ELRS Mobile
**Analysis Date**: 2026-08-27
**Surfaces**: Mobile app (Android/iOS), embedded device WebView, marketing/docs website

## Experience Principles

- **Offline-first, field-ready workflow** — the product is a two-phase job: cache firmware and hardware definitions while on home Wi-Fi, then flash in the field with no internet. Cached versions are labeled "Ready for offline use"; the Firmware Manager is the deliberate first stop.
- **Automatic connection over manual configuration** — on launch the app continuously scans via mDNS plus static-candidate probing (`elrs_rx.local`, `elrs_tx.local`, `10.0.0.1`) and connects with no user action. Manual IP entry is a fallback behind a gear icon.
- **Outdoor / sunlight readability** — thicker progress bars (`minHeight: 6`), a bright cyan accent (`#00E5FF`), bold uppercased status text, dark theme throughout.
- **Guarded destructive actions** — every irreversible step is gated by an explicit confirmation: non-dismissible first-launch legal disclaimer, target-mismatch force-flash, empty-binding-phrase, and cache/profile deletion dialogs.
- **Progressive disclosure via Expert Mode** — STM32/legacy targets, raw binary download, Lua export, and debug reporting are hidden until enabled in Settings.
- **Flash-lifecycle resilience** — during flashing the app locks orientation to portrait (prevents provider `autoDispose` teardown), silences heartbeat/discovery timers, and runs an aggressive post-flash reconnection grace period while the device reboots.
- **Reusable named configuration profiles** — binding phrase, Wi-Fi credentials, regulatory domains, and Wi-Fi-on interval bundle into named Flashing Profiles so users switch whole configurations instead of re-entering fields.
- **Delegate device configuration to the device's own UI** — per-device parameter editing is not reimplemented natively; the app embeds the ExpressLRS web UI served by the device inside a locked WebView.

## Actors & Surfaces

| Actor | Surface | Goal | Entry Points |
|-------|---------|------|--------------|
| Hobbyist RC pilot (default) | Mobile app (Dashboard, Flashing, Firmware Manager, Device Config WebView, Support) | Cache firmware at home, auto-connect to RX/TX, flash OTA with a saved profile, adjust device settings | App launch -> Splash -> Dashboard |
| Power user / Expert | Mobile app with Expert Mode; external tools (STLink, Betaflight passthrough) | Flash legacy STM32 hardware, download patched binary, export Lua script, submit debug reports | Settings -> Expert Mode |
| Radio / tablet user (landscape) | Mobile app landscape layouts | Use on a wide display such as an AX12-class radio touchscreen | Any screen, landscape orientation |
| New / prospective user | Website docs (Astro/Starlight), in-app Support screen, community links | Install the app, learn the flashing and recovery workflow | External browser; Dashboard -> Help & Support |

## Primary Actions

### Splash screen (`/`)
**Role**: branding, version display, disclaimer of official affiliation, timed hand-off. **Primary action**: passive — auto-navigates to `/dashboard` after ~3 s.

### Dashboard (`/dashboard`, home)
**Role**: connection-status hub and navigation launcher. **Primary actions**: view the hardware status card (product / version / target / domain / match), open the manual IP dialog, retry discovery, navigate to Flash Device, Device Config, Firmware Manager, Settings, Help & Support. **Constraint**: first-launch disclaimer dialog blocks all interaction until accepted.

### Flashing screen (`/flashing`)
**Role**: assemble and push firmware (or build/save a binary). **Primary actions**: cascading target selection (Device Type > Vendor > Frequency > Target), configure the options card, tap **FLASH**, **DOWNLOAD BINARY** (Expert Mode), confirm/cancel the mismatch and no-bind-phrase dialogs. **Constraint**: STM32 targets disable OTA ("OTA UNAVAILABLE"); orientation locked to portrait while active.

### Firmware Manager (`/firmware_manager`)
**Role**: download and cache firmware versions for offline use; manage local storage budget. **Primary actions**: refresh the version list, download a version, delete a cached version, watch the storage-used bar against `maxCachedVersions`.

### Device Config WebView (`/device_config`)
**Role**: host the device's own embedded ExpressLRS web configuration UI. **Primary actions**: interact with the device web UI (parameters, PWM mapping, OTA via device page), pick a firmware `.bin`/`.gz` via the native file-selector bridge (Android). **Constraint**: navigation locked to the device IP; external navigation blocked.

### Settings (`/settings`)
**Role**: manage profiles, network defaults, storage limits, preferences, Expert/diagnostic tools. **Primary actions**: select/add/delete a Flashing Profile; edit binding phrase, Wi-Fi SSID/password, Wi-Fi-on interval; set default regulatory domains; adjust max cached versions; clear the firmware cache; toggle analytics sharing; toggle Expert Mode; change the language override; export Lua / submit debug report (Expert).

### Help & Support (`/support`)
**Role**: in-app walkthrough, FAQ, community/recovery links. **Primary actions**: read the tabbed Flashing Guide / FAQ / Resources (TabBar portrait, NavigationRail landscape), expand recovery steps, launch external links (Discord, GitHub, web-flasher, recovery video), view the full disclaimer.

### Legal Notice (`/legal`)
**Role**: full legal/liability text. **Primary action**: read.

### Website documentation (Astro / Starlight, external)
**Role**: public install instructions and the canonical flashing/recovery guide. **Primary actions**: read the guide, follow app-store / GitHub install links.

## User-Visible States

| State | Meaning | Surface Signals |
|-------|---------|-----------------|
| Scanning for device | Actively searching the local network, no device confirmed | Pulsing teal ring icon; mDNS badge "Scanning..." / "Searching..." with `wifi_find` icon |
| Connected to device | Live ELRS device confirmed at a known IP | Cyan-bordered elevated card with `check_circle`; product name, "Connected: `<ip>`", version/target chips, regulatory-domain badge; "Connected (`<ip>`)" chip with green wifi icon |
| No device found | Discovery ran, nothing responded | Grey `wifi_off` icon, "No Device Found", inline **Retry** button |
| Target match vs mismatch | Selected firmware target vs the connected device's reported product name | Green `check_circle` "Matched" / orange `warning_amber` "Mismatch" chip; blocking dialog on flash |
| Flashing status machine | Lifecycle: idle, downloading, patching, uploading, success, downloadSuccess, error, mismatch | `LinearProgressIndicator` with fractional value; uppercased status text; colored inline text (red error / green "Device is rebooting"); success snackbars; button label swaps "WAITING FOR DEVICE...", "OTA UNAVAILABLE", "FLASH", "DONE" |
| Firmware version cache state | Per version: not cached / downloading / cached-offline-ready | `cloud_download` blue icon / `CircularProgressIndicator` / green `dns` icon + "Ready for offline use" + delete icon |
| Storage budget level | Cached-version count vs configured max | Header bar color: blue normal, orange above 80%, red at/over limit; "N / limit Versions" count turns red when full |
| STM32 / legacy target selected | Target cannot be flashed OTA | Amber warning card (STLink / Betaflight passthrough); primary button disabled "OTA UNAVAILABLE"; DOWNLOAD BINARY offered in Expert Mode |
| WebView config loading | Device web UI page not finished loading | Centered cyan `CircularProgressIndicator` overlay until `onPageFinished` |

## Feedback Loops

- **Flash progress and completion** — tap FLASH with a connected device -> progress bar advances through downloading/patching/uploading, status text updates -> success snackbar + green "Device is rebooting" + button relabels to DONE -> device auto-reconnects after reboot (Dashboard card animates back to Connected).
- **Target mismatch guard** — flash attempted while selected target != connected product -> non-dismissible "Target Mismatch" dialog with CANCEL / red FORCE FLASH; cancel resets status, force calls `forceUpdate()`.
- **Missing binding phrase guard** — flash attempted with no phrase (`NO_BIND_PHRASE`) -> "No Binding Phrase" dialog with CANCEL / PROCEED; PROCEED re-flashes with `ignoreMissingBindPhrase`.
- **First-launch disclaimer gate** — settings loaded with `disclaimerAccepted == false` -> non-dismissible disclaimer over the Dashboard; must accept to proceed.
- **Discovery retry** — tap Retry on "No Device Found" -> `restartDiscovery()` resets mDNS found-state and relaunches full pre-connection discovery; card returns to scanning.
- **Manual IP override** — tap the gear icon on the hardware card -> dialog with a custom numeric IP keypad; Connect enabled only when the address matches the IPv4 regex; `setManualIp` adds the address to the probe candidate list.
- **Firmware cache management** — tap download/delete on a version row -> trailing swaps to a spinner during download, then to green "Ready for offline use" or back to the download icon; storage header bar and count update.
- **Post-flash auto-reconnect** — flash completes and the device reboots -> heartbeat/discovery timers resume in an aggressive grace period -> on reconnect the hardware card animates back to Connected, otherwise "device did not reconnect" is logged.
- **Language override selection** — tap the language icon (Settings / Flashing AppBar) -> dialog lists locales with a check on the active one -> selection applies an app-locale override; Support/FAQ content reloads localized (fallback to the default asset).
- **Clear cache confirmation** — tap "Clear firmware cache" -> confirmation dialog -> snackbar confirming the cache was cleared.

## Accessibility & Discoverability

- **Orientation locked to portrait during flashing** — prevents Riverpod `autoDispose` teardown mid-flash; restored to all orientations on leaving the screen.
- **High-contrast, large-target visuals for outdoor use** — thicker progress indicators, bright cyan accent, bold uppercased labels, dark theme.
- **Custom large numeric keypad for IP entry** (`packages/ip_address_keypad`) — field-friendly input independent of the system soft keyboard, with a `10.0.0.1` preset shortcut and inline validation gating Connect.
- **Tooltips on icon-only controls** — gear, language, add-profile, delete-profile, manual-connection icon buttons.
- **Localized content with graceful fallback** — FAQ/help content loads a locale-specific asset and falls back to the default when absent; explicit language override independent of the system locale.
- **WebView background color matched to the app dark theme** — avoids a white flash while the device config page loads.
- **Gap: no reduced-motion or semantic live-region handling** — pulsing ring, splash fade, and `AnimatedSwitcher` animations run unconditionally; flash status changes are conveyed visually / by snackbar only, with no announced live region or `MediaQuery.disableAnimations` check. No `Semantics` / `HapticFeedback` usage found in `lib/src`.

## Cross-Surface Deltas

| Behavior | Surfaces | Delta | Reason |
|----------|----------|-------|--------|
| Screen layout for wide displays | Settings, Support, Splash, Dashboard | Portrait: single scrolling list / TabBar / 2-column grid. Landscape: master-detail sidebar (Settings), NavigationRail (Support), Row-based Splash, 3-column Dashboard grid | Support AX12-class landscape radio touchscreens and tablets |
| Device parameter configuration | Flashing screen vs Device Config WebView | Flashing uses native Flutter controls; per-device settings delegated to the device's embedded web UI in a locked WebView | Reuse the device's own maintained UI instead of reimplementing it |
| Available targets and tools | Flashing screen, Settings | Default hides STM32 targets, DOWNLOAD BINARY, Lua export, debug reporting; Expert Mode reveals all | Keep the common OTA path simple; STM32/diagnostics are advanced, error-prone |
| Flash delivery method by platform | Flashing screen vs external tools | Standard targets flash OTA in-app; STM32 targets disable OTA and require a downloaded patched binary flashed via STLink or Betaflight passthrough | STM32 hardware has no OTA capability |
| Onboarding / walkthrough content | Website docs vs in-app Support | Website carries install/app-store links + the canonical phased flashing guide; in-app Support mirrors the phased walkthrough + FAQ + recovery, localized with fallback | Website serves acquisition; in-app serves offline field reference |
| Update checking | Mobile app vs app stores | Legacy in-app Gist-based update check is now a no-op; app updates handled entirely by the stores | App is distributed via Google Play and the App Store |

## Related KB Links

- System topology: [architecture.md](architecture.md)
- Component inventory: [modules.md](modules.md)
- Terminology: [concept_map.md](concept_map.md)
- Implementation details: [patterns.md](patterns.md)
