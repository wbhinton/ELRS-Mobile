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

## Analytics and Monitoring
The application utilizes a multi-tier observability strategy to balance user privacy with technical reliability:

1. **Aptabase (Usage Analytics)**: We use Aptabase for privacy-first, opt-in usage tracking. This helps us understand which features (like specific flashing targets or firmware versions) are most commonly used to prioritize development efforts.
2. **Sentry (Error Reporting)**: The app integrates `sentry_flutter` for real-time monitoring of unexpected runtime exceptions and flashing pipeline failures. 

This suite ensures high reliability for hardware-management bridging while keeping "Analytics disabled by default" for user privacy.

## Cellular Fallback & Forced Routing
Mobile operating systems (especially newer Android and iOS versions) will automatically drop or deprioritize Wi-Fi connections that do not provide internet access, silently routing traffic over 5G/LTE instead. This causes apps to fail to connect to ELRS hardware hotspots (like `10.0.0.1`). 

ELRS Mobile solves this natively. When the app detects an active connection to an ELRS hotspot, the `NativeNetworkService` invokes a platform-specific `MethodChannel` (`org.expresslrs.elrs_mobile/network`) to execute `bindProcessToWiFi`. This forcibly binds the entire Flutter app process directly to the Wi-Fi interface at the OS level, guaranteeing that all HTTP requests and MDNS discovery packets reach the hardware, entirely bypassing the OS's cellular fallback logic.
