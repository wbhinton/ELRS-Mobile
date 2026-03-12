# Project Roadmap & Strategy

This document outlines the strategic priorities for the ELRS Mobile App, based on analysis from OpenCode/RP1 and Antigravity.

- [x] Debug WiFi Routing: Resolve issue where cellular data overrides local WiFi connection.

## Strategic Analysis Overview
The app has a solid foundation (Flutter, Clean Architecture, Riverpod), but several "technical debt" items and optimization opportunities exist that will improve long-term stability and user experience.

| Priority | Recommendation | Estimated Effort | Status |
| :--- | :--- | :--- | :--- |
| **Critical** | Implement firmware cache eviction | 4-6 hrs | [x] |
| **Critical** | Fix WebView JS vulnerability | 30 min | [x] |
| **Critical** | Implement encrypted credential storage | 2 hrs | [x] |
| **High** | Fix mDNS fallback (Dead Timer) | 1-2 hrs | [x] |
| **High** | Remove debug firmware artifacts | 10 min | [x] |
| **Medium** | Optimize heartbeat logic | 3-4 hrs | [ ] |
| **Medium** | Move binary patching to Isolates | 4-6 hrs | [ ] |
| **Medium** | Add input validation (SSID/Password) | 2 hrs | [x] |

---

## Detailed Recommendations & Commentary

### 1. Implement Cache Eviction Policy
*   **Analysis**: `firmware_cache_service.dart` currently saves every downloaded version but never deletes them.
*   **Antigravity's Take**: **Must Fix**. The UI already has a "Max Cached Versions" setting, but the backend logic is missing. We should implement a "Last-In, First-Out" or "Version-based" cleanup to prevent the app from consuming gigabytes of phone storage over time.

### 2. Structured Logging
*   **Analysis**: The app currently uses `print()` for everything, which is "lost" in production.
*   **Antigravity's Take**: **Highly Recommended**. Switching to the `logging` package allows us to capture logs in Sentry during failures. This makes remote debugging possible for users having issues with specific hardware modules.

### 3. mDNS Fallback (The "Discovery Fix")
*   **Analysis**: `discovery_service.dart` has a dead `Timer` where a fallback should be.
*   **Antigravity's Take**: **Best ROI**. Fixing this will allow the app to immediately try `10.0.0.1` if mDNS is slow to respond. This eliminates the "why is it taking so long to connect?" feeling for new users.

### 4. Remove Debug Firmware Artifacts
*   **Analysis**: `device_repository.dart` contains code that saves a binary file to the `Documents` directory on every build.
*   **Antigravity's Take**: **Fixed**. Removed legacy debug code from `DeviceRepository` to prevent credential exposure.

### 5. Optimize Heartbeat Logic
*   **Analysis**: The current heartbeat in `ConfigViewModel` is functional but "chatty".
*   **Antigravity's Take**: **Good Refinement**. We can make this smarter about differentiating between "Device Offline" and "WiFi Network Switched."

### 6. Binary Patching with Isolates
*   **Analysis**: Firmware assembly (merging JSON layers into `.bin`) happens on the main UI thread.
*   **Antigravity's Take**: **UX Polish**. On older devices, the UI might stutter for a second during assembly. Moving this to a background Isolate ensures a butter-smooth experience.

---

## Security Analysis & Strategy ⚠️

RP1/OpenCode performed a security audit identifying several critical blockers for release.

### 1. Unrestricted WebView JavaScript
*   **Analysis**: `device_settings_screen.dart` uses `JavaScriptMode.unrestricted`.
*   **Antigravity's Take**: **Fixed**. Implemented `NavigationDelegate` to restrict WebView navigation to local device IPs only.

### 2. Unencrypted Credential Storage
*   **Analysis**: WiFi passwords and Binding Phrases are stored in plain text in `SharedPreferences`.
*   **Antigravity's Take**: **Fixed**. Migrated sensitive credentials to `flutter_secure_storage` with auto-migration from older versions.

### 3. Debug Firmware Write
*   **Analysis**: The app writes a binary file containing user credentials to the public `Documents` directory.
*   **Antigravity's Take**: **Fixed**. Forensic write logic has been entirely removed from the codebase.

### 4. Input Validation & Cryptography
*   **Analysis**: Missing validation on user inputs and use of MD5.
*   **Antigravity's Take**: 
    *   **Input Validation**: We need to sanity check SSIDs (max 32 chars) and passwords. 
    *   **MD5 Note**: While MD5 is "weak," it is unfortunately mandated by the ELRS protocol for generating the 6-byte UID. We cannot change the protocol-level MD5, but using **Encrypted Storage** as mentioned above makes the local storage secure.

---

## Target Files
- `lib/src/features/configurator/presentation/device_settings_screen.dart`
- `lib/src/core/storage/persistence_service.dart`
- `lib/src/features/flashing/data/device_repository.dart`
- `lib/src/features/flashing/utils/firmware_assembler.dart`
- `lib/src/core/storage/firmware_cache_service.dart`
- `lib/src/core/networking/discovery_service.dart`
- `lib/src/features/config/presentation/config_view_model.dart`

