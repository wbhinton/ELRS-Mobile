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
**Analysis Date**: 2026-10-27 (commit 3e8eab5, v1.0.45+111)
**Surfaces**: Mobile app (Android/iOS/macOS; store and direct-download APK builds), embedded device WebView, website (landing, docs, hardware list, privacy)

## Experience Principles

- **Offline-first, field-ready workflow**: cache firmware at home (Firmware Manager is the first stop; cached versions read "Ready for offline use"), flash anywhere. The normal flash path is locating → unpacking from cache; "downloading" appears only as a fallback; a missing cache is a typed `OfflineMissingFiles` error. The website tells the same story (three "How it works" steps, use cases).
- **Automatic connection over manual configuration**: mDNS plus probes of `elrs_rx.local`, `elrs_tx.local`, `10.0.0.1`; manual IP sits behind the gear icon on the Dashboard card.
- **Outdoor readability**: dark theme, bright cyan accent, thick progress bars, bold uppercase status. The website is dark-only too.
- **Guard risky actions; hard-block impossible ones**: confirmations for the first-launch disclaimer, Force Flash, empty binding phrase, cache/profile deletion. A chip-family mismatch is blocked outright with no override.
- **Truthful outcomes**: success only when the device replies `ok`. A silent drop after the full upload is shown as an amber "not confirmed" warning, never as success; mid-upload drops are red failures.
- **Non-stalling progress**: upload progress scaled into 66–95 %; an indeterminate "Writing to Device — Please Wait" (`finalizing`) covers the device's silent write/reboot.
- **Flash-lifecycle resilience**: portrait lock, wakelock, discovery/heartbeat paused, aggressive reconnect after reboot.
- **Progressive disclosure**: Expert Mode reveals STM32 targets, Download Binary, Lua export, debug report.
- **Reusable profiles**: binding phrase, Wi-Fi, regulatory defaults, Wi-Fi interval bundled per profile; managed in Settings, selectable on the flashing screen.
- **Delegate device settings to the device**: the device's own web UI in a locked WebView is the only editor.
- **Everything localized, and enforced**: 18 locales; typed errors render a localized headline plus untranslated technical detail; tests fail on hard-coded text.
- **Consistent firmware claim**: "3.3.x and 4.x" across splash, website and docs.

## Actors & Surfaces

| Actor | Surface | Goal |
|-------|---------|------|
| Hobbyist pilot (default) | App, Device Config WebView, website | Cache firmware, auto-connect, flash with a profile, adjust device settings |
| Power user / Expert | App with Expert Mode; STLink / Betaflight passthrough | STM32 binaries, Download Binary, Lua export, debug reports |
| Radio / tablet user (landscape) | Landscape layouts | Use on AX12-class radio screens and tablets |
| Prospective user | Website landing, hardware list, videos, store badges | Check hardware support, see it working, install |
| Sideload / direct-APK user (incl. RadioMaster-distributed link) | Direct build update dialog, Settings → Check for Updates | Install without Play and still learn about updates |
| Non-English speaker | App language picker, localized website | Use app, FAQ and site in their language |
| Contributor | Developer docs (English-only) | Build, test, validate firmware |

## Primary Actions

- **Splash (`/`)**: passive, ~3 s hand-off.
- **Dashboard (`/dashboard`)**: status card (scanning / connected / not found), Retry, manual IP, navigation to Flash Device, Device Config, Firmware Manager, Settings, Help & Support. Launch dialogs appear one at a time: legal disclaimer (first launch, non-dismissible) → "Saved Settings Reset" (once, if the storage upgrade dropped data) → update dialog (direct builds).
- **Flashing (`/flashing`)**: target auto-selected from the connected device when possible, else cascading Device Type > Vendor > Regulatory & Frequency > Target; version selector (cached marked, "requires vX or newer" with Download Compatible Firmware); options card with profile; FLASH; DOWNLOAD BINARY (Expert).
- **Firmware Manager (`/firmware_manager`)**: refresh, download, delete; storage bar vs `maxCachedVersions`.
- **Device Config (`/device_config`)**: device web UI; `.bin`/`.gz` picker bridge on Android.
- **Settings (`/settings`)**: four categories (Profiles & Network, App & Storage, Advanced & Debug, About & Legal); Share Analytics (default on); Expert tools; Check for Updates (direct builds); language button in the app bar.
- **Help & Support (`/support`)**: Flashing Guide / FAQ / Resources, recovery steps, external links.
- **Legal (`/legal`)**: full disclaimer and license.
- **Website**: hero with store CTAs and "38,000+ installs / 15,000+ flashes" stats; how it works with demo video; feature tour; use cases; compatibility stats; community videos (click-to-play); install options; docs with searchable, verified-badged hardware list; privacy page.

## User-Visible States

| State | Signals |
|-------|---------|
| Scanning | Pulsing teal ring, "Scanning..." badge |
| Connected | Cyan-bordered card, product, IP, version/target chips, domain badge |
| No device found | Grey `wifi_off`, "No Device Found", Retry |
| Target matched / mismatch | Green "Matched" / orange "Mismatch" chip; blocking dialog on flash |
| Flash phases | Localized uppercase labels per phase; indeterminate bar in finalizing; button labels Waiting for Device / OTA Unavailable / Flash / Done |
| Flash error (typed) | Localized headline + optional technical detail; red, except amber for FlashUnconfirmed |
| Chip mismatch | Error naming both chips; no Force Flash |
| STM32 selected | Amber warning card, OTA Unavailable, Download Binary (Expert) |
| Firmware cache per version | Download icon / spinner / green "Ready for offline use" + delete |
| Storage budget | Blue → orange (> 80 %) → red at limit |
| Update available (direct) | Dialog: Download / Later / Skip This Version; manual check → snackbar if up to date or failed |
| Saved Settings Reset | One-time dialog after a storage upgrade dropped data from ≤ 1.0.43 |
| WebView loading | Cyan spinner until page finished |

## Feedback Loops

- **Flash**: FLASH → phases → device `ok` → green "Flashing Successful! Device is rebooting", snackbar, DONE → auto-reconnect. Mid-upload drop → red failure; post-upload silence → amber unconfirmed.
- **Target mismatch**: dialog (Cancel / red Force Flash) → forced re-upload `?force=1` → `/forceupdate` only if still mismatched.
- **Chip guard**: blocked immediately with an explanation.
- **Missing binding phrase**: dialog (Cancel / Proceed).
- **Discovery retry / manual IP**: Retry restarts discovery; IP keypad enables Connect only for valid IPv4.
- **Cache management**: spinner → ready / removed; typed, localized download errors (e.g. "on device hotspot").
- **Language override**: dialog with checkmark; UI and FAQ reload localized.
- **Update check (direct)**: automatic ≤ 24 h after Dashboard dialogs, or manual from Settings with in-progress state and duplicate-tap protection.
- **Website**: store/donate clicks send `data-track` analytics (one event per click); videos load only on play; hardware search filters in place.

## Accessibility & Discoverability

- Portrait lock during flashing; high-contrast visuals; custom numeric IP keypad with a `10.0.0.1` shortcut; tooltips on icon buttons; localized content with fallback and overflow tests; WebView background matches the dark theme; colour always paired with text (amber vs red distinguishes unknown from failed).
- **Gap**: no reduced-motion handling, `Semantics`, live regions or haptics in `lib/src`; animations and status changes are visual only.
- Website: click-to-play media, mobile header keeps CTA and docs (icon) reachable at 360 px, language picker in the footer on every page.

## Cross-Surface Deltas

| Behavior | Delta | Reason |
|----------|-------|--------|
| Wide displays | Master-detail Settings, NavigationRail Support, 3-column Dashboard in landscape | Radio screens and tablets |
| Device settings | Native flashing controls; device settings only in the device web UI | Reuse the device's maintained UI |
| Expert tools | Hidden by default | Keep the common path simple |
| STM32 | No OTA; build and save for PC flashing (3.3.x only) | No Wi-Fi updates on STM32 |
| Update checking | Store builds: none (stores update). Direct APK: 24 h check + Settings tile | Sideloaded APKs get no store updates |
| Analytics vs crashes | Aptabase obeys Share Analytics (default on); Sentry runs in all release builds regardless | Keep crash visibility; disclosed in the privacy policy |
| Permissions | Android requests no location; iOS `Info.plist` still declares unused location/camera/photo strings | Platform differences; iOS strings likely vestigial |
| Language | App 18 locales; website localized except developer docs (English-only) | Translation cost vs value |
| Onboarding | Website: acquisition, canonical guide, hardware list. In-app Support: offline guide, FAQ, recovery | Different contexts |

## Related KB Links

- System topology: [architecture.md](architecture.md)
- Components: [modules.md](modules.md)
- Terminology: [concept_map.md](concept_map.md)
- Conventions: [patterns.md](patterns.md)
