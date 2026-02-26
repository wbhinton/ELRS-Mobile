ExpressLRS Mobile is a modern, cross-platform companion application built with Flutter, designed to simplify the management, configuration, and flashing of ExpressLRS hardware directly from your mobile device or desktop.

Whether you are configuring a new receiver on the bench or flashing an emergency update in the middle of a field with no cellular service, ELRS Mobile provides a seamless, robust Over-The-Air (OTA) experience.

*Note: This is an independent, community-driven tool and is not officially affiliated with, sponsored by, or endorsed by ExpressLRS LLC. Compatible with ExpressLRS 3.x and 4.x firmware.*

**Key Features**
- 100% Offline Flashing: Prepare for the field using the Firmware Manager. The app caches complete firmware releases (firmware.zip and hardware.zip directly from Artifactory), allowing you to dynamically assemble and flash firmware targets without an internet connection.
- Mobile-First Workflow: No USB cables, no Python environments, no driver issues. Connect to your receiver or transmitter's Wi-Fi hotspot and flash directly from your phone.
- Device Configurator & Native WebUI: Automatically discover devices on your network via mDNS. View live hardware status, configure PWM pins, adjust Model Match, or instantly access the device's native ELRS WebUI through the app's embedded WebView.
- Smart Hardware Resolution: Features an intuitive cascading selection system (Device Type ➔ Vendor ➔ Frequency ➔ Target) ensuring you always build the correct payload for your hardware.
- Cellular Fallback Protection: Natively forces your phone's network traffic through the Wi-Fi interface (preventing the OS from dropping the connection when it detects "No Internet" on the ELRS hotspot).

--------------------------------------------------------------------------------
**How to Use ELRS Mobile**

*Phase 1: Caching Firmware (Do this at home)*
1. Open the app and navigate to the Firmware Manager.
2. Tap the download icon next to the latest stable release (e.g., 3.4.0).
3. The app will download and securely cache the required target and hardware definitions for offline use.

*Phase 2: Connecting to Your Device*

1. Power on your ExpressLRS Receiver (RX) or Transmitter (TX).
2. Wait 60 seconds (or your configured interval) for the device to enter Wi-Fi Hotspot Mode (rapid blinking LED).
3. Connect your phone's Wi-Fi to the ExpressLRS RX or ExpressLRS TX network (Password: expresslrs).
4. Open the app. The Dashboard will automatically scan the network using mDNS and connect to the device, displaying its current firmware version and hardware target.

*Phase 3: Flashing Firmware*

1. From the Dashboard, select Flash Device.
2. Select your Hardware: Use the cascading dropdowns to select your Device Type (e.g., RX), Vendor (e.g., RadioMaster), Frequency (e.g., 2.4GHz), and Target.
3. Configure Options: Set your custom Binding Phrase, Wi-Fi credentials, and Regulatory Domain.
4. Tap FLASH. The app will assemble the binary and push it to the device. Wait for the success confirmation and for the LED on your device to resume blinking before unplugging!

--------------------------------------------------------------------------------
*Installation*
Current Release: You can install the latest version of ELRS Mobile directly from the GitHub Releases page.
- Android: Download and install the .apk file. (Note: You may need to enable "Install from Unknown Sources" in your Android settings).

Coming Soon: If there is enough interest generated, we plan to publish ELRS Mobile to the Google Play Store and Apple App Store in the near future to make installation and updates seamless.

--------------------------------------------------------------------------------
*Under the Hood: Technical Architecture*

ELRS Mobile is not just a web-wrapper; it is a native Dart implementation of the ExpressLRS compilation and configuration pipeline.
Unified Firmware Assembly
Instead of relying on a remote cloud compiler, the app dynamically builds binaries locally on your device. When flashing ESP32/ESP8285 targets, the FirmwareAssembler:
1. Extracts the base generic firmware from the cached firmware.zip.
2. Trims the base padding by seeking the ESP 0xE9 magic byte.
3. Extracts your specific target's pinout and configuration from hardware.json.
4. Byte-packs the 128-byte Product Name, 16-byte Lua Name, 512-byte user options.json, and 2048-byte hardware.json directly into the end of the binary stream.
5. Compresses the final payload into a .gz file dynamically if the target platform (like esp8285) strictly requires it.

*Regulatory Domain Logic*

The app accurately handles the complex differences between frequency bands. For 900MHz/Dual-Band devices, it actively injects your chosen domain (e.g., FCC, EU868) into the compiled JSON payload. For standard 2.4GHz targets, it utilizes a boolean flag to silently route the extraction process to either the standard FCC/ or European LBT/ base firmware folders during assembly.

*Note on Firmware Auditing and Byte-Perfect Matches*

When running Ground Truth audit tools, you may notice that binaries generated by ELRS Mobile perfectly match the official ExpressLRS Web Flasher, but diverge slightly from binaries built using the local Python ExpressLRS Configurator.

This is expected behavior and does not affect hardware compatibility. The local Configurator uses Python's json.dumps() to assemble configuration metadata, which injects whitespace after colons and commas (e.g., {"uid":, "domain": 1}). ELRS Mobile and the official Web Flasher use dense, minified JSON (e.g., {"uid":,"domain":1}). The ESP32's internal C++ JSON parser ignores whitespace, meaning both binaries execute identically on the hardware despite failing a strict byte-for-byte SHA256 comparison.

*Supported Platforms*
- Supported: All ESP8285, ESP32, ESP32-C3, and ESP32-S3 Wi-Fi capable receivers and transmitters.
- Currently Unsupported: STM32 targets requiring serial STLink or Betaflight Passthrough flashing.

--------------------------------------------------------------------------------
*License & Attribution*
- Software License: This project is licensed under the GPLv3.
- Trademark Notice: "ExpressLRS" is a trademark of ExpressLRS LLC.
- Credits: Massive thanks to the ExpressLRS development team. The open-source nature of their Configurator, Web Flasher, and WebUI made reverse-engineering this native Flutter implementation possible.