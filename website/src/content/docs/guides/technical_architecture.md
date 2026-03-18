---
title: Technical Architecture
slug: technical_architecture
---

ELRS Mobile is not just a web-wrapper; it is a native Dart implementation of the ExpressLRS compilation and configuration pipeline.

## Unified Firmware Assembly
Instead of relying on a remote cloud compiler, the app dynamically builds binaries locally on your device. When flashing ESP32/ESP8285 targets, the `FirmwareAssembler`:
1. Extracts the base generic firmware from the cached `firmware.zip`.
2. Trims the base padding by seeking the ESP `0xE9` magic byte.
3. Extracts your specific target's pinout and configuration from `hardware.json`.
4. Byte-packs the 128-byte Product Name, 16-byte Lua Name, 512-byte user `options.json`, and 2048-byte `hardware.json` directly into the end of the binary stream.
5. Compresses the final payload into a `.gz` file dynamically if the target platform (like esp8285) strictly requires it.

## Regulatory Domain Logic
The app accurately handles the complex differences between frequency bands. For 900MHz/Dual-Band devices, it actively injects your chosen domain (e.g., FCC, EU868) into the compiled JSON payload. For standard 2.4GHz targets, it utilizes a boolean flag to silently route the extraction process to either the standard FCC/ or European LBT/ base firmware folders during assembly.

## Firmware Caching
Offline flashing is made possible through a robust local caching system. When a user downloads a release via the Firmware Manager, the `FirmwareCacheService` pulls the generic `firmware.zip` and device-specific `hardware.zip` directly from the ExpressLRS Artifactory. These archives are managed and stored locally on the device, ensuring assembly and flashing can occur instantly in the field without any active internet connection.

## Persistent Storage
To streamline the user experience, volatile but frequently reused configuration data—such as custom Binding Phrases, Wi-Fi SSIDs, and network passwords—are securely saved to the device using `SharedPreferences`. This prevents users from having to repeatedly re-enter complex network credentials or binding strings every time they flash a new device.

## Analytics & Observability
The application utilizes a multi-tier observability strategy to balance user privacy with technical reliability:

1. **Aptabase (Usage Analytics)**: Privacy-first, opt-in usage tracking. We track feature adoption (e.g., specific flashing targets) to prioritize development efforts.
2. **Sentry (Error Reporting)**: Real-time monitoring of runtime exceptions and flashing pipeline failures.
3. **Expert Mode Auditing**: Local binary export for bitwise parity verification against community standards.

---

## Native Network Binding
Mobile operating systems (especially Android and iOS) will deprioritize Wi-Fi connections that lack internet access, silently routing traffic over cellular instead. This prevents standard apps from reaching ELRS hardware at `10.0.0.1`.

ELRS Mobile solves this via the `NativeNetworkService`. When a hardware connection is detected, the app invokes a platform-specific `MethodChannel` (`org.expresslrs.elrs_mobile/network`) to bind the entire Flutter process to the Wi-Fi interface at the OS kernel level. This ensures all HTTP and mDNS traffic routes correctly to the hardware, regardless of cellular status.
