<p align="center">
  <img src="icons/elrs_mobile.png" alt="ExpressLRS Mobile Logo" width="150"/>
</p>

[![Google Play](https://img.shields.io/badge/Google%20Play-Get%20It%20On-blue.svg?style=flat-square&logo=google-play&logoColor=white)](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile)
[![App Store](https://img.shields.io/badge/App--Store-Download-blue?style=flat-square&logo=apple&logoColor=white)](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
[![GitHub Release](https://img.shields.io/github/v/release/wbhinton/ELRS-Mobile?style=flat-square&color=orange)](https://github.com/wbhinton/ELRS-Mobile/releases)
[![Build Status](https://img.shields.io/github/actions/workflow/status/wbhinton/ELRS-Mobile/release.yml?branch=main&style=flat-square)](https://github.com/wbhinton/ELRS-Mobile/actions)
[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=flat-square&logo=Flutter&logoColor=white)](https://flutter.dev)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg?style=flat-square)](https://www.gnu.org/licenses/gpl-3.0)
[![GitHub Store](https://raw.githubusercontent.com/OpenHub-Store/Github-Store/main/media-resources/ghs_download_badge.png)](https://github.com/OpenHub-Store/Github-Store)

# ExpressLRS Mobile

### [🌐 Official Website & Documentation (elrsmobile.com)](https://elrsmobile.com)

ExpressLRS Mobile is a modern, cross-platform companion application built with Flutter, designed to simplify the management, configuration, and flashing of ExpressLRS hardware directly from your mobile device or desktop.

Whether you are configuring a new receiver on the bench or flashing an emergency update in the middle of a field with no cellular service, ELRS Mobile provides a seamless, robust Over-The-Air (OTA) experience.

*Note: ELRS Mobile is an independent, community-driven FOSS project developed by Weston Hinton. This project is not an official product of ExpressLRS LLC and is not officially supported, endorsed, or certified by the ExpressLRS development team. For the official ExpressLRS configurator and documentation, please visit [expresslrs.org](https://www.expresslrs.org).*

🚀 **Quick Start**

The easiest way to get started with ELRS Mobile is by installing it from your device's official app store.

### 1. Install the App
- **Android (Google Play):** [Get it on Google Play](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile).
- **Android (GitHub Store):** [Download on GitHub Store](https://github.com/OpenHub-Store/Github-Store).
- **iOS (App Store):** [Download on the App Store](https://apps.apple.com/us/app/elrs-mobile/id6760490014).
- **Alternative (Android Only):** Download the raw `.apk` from the [Releases Page](https://github.com/wbhinton/ELRS-Mobile/releases).

### 2. Connect & Flash ([Detailed Instructions](https://elrsmobile.com/user_guide))
- **Power On:** Turn on your ELRS hardware and wait for it to enter Wi-Fi Hotspot mode (rapid blinking LED).
- **Join Network:** Connect your phone to the `ExpressLRS RX` or `ExpressLRS TX` Wi-Fi hotspot (Password: `expresslrs`).
- **Launch:** Open the app. It will auto-detect your device via mDNS and you're ready to go!


**Key Features**
- 100% Offline Flashing: Prepare for the field using the Firmware Manager. The app caches complete firmware releases (firmware.zip and hardware.zip directly from Artifactory), allowing you to dynamically assemble and flash firmware targets without an internet connection.
- Mobile-First Workflow: No USB cables, no Python environments, no driver issues. Connect to your receiver or transmitter's Wi-Fi hotspot and flash directly from your phone.
- Device Configurator & Native WebUI: Automatically discover devices on your network via mDNS. View live hardware status, configure PWM pins, adjust Model Match, or instantly access the device's native ELRS WebUI through the app's embedded WebView.
- Smart Hardware Resolution: Features an intuitive cascading selection system (Device Type ➔ Vendor ➔ Frequency ➔ Target) ensuring you always build the correct payload for your hardware.

> [!TIP]
> **Pro-Tip:** ELRS Mobile natively handles forced routing, ensuring your phone doesn't silently switch back to 5G/LTE when it realizes the ELRS hotspot has no internet. This completely eliminates the most common "connected but can't see the receiver" issue out in the field.

--------------------------------------------------------------------------------
**Demo Video**

[![Flash ELRS from your iPhone](https://img.youtube.com/vi/v1gV7t4i-dA/maxresdefault.jpg)](https://www.youtube.com/shorts/v1gV7t4i-dA)
*Click the image above to watch the mobile flashing demo!*

--------------------------------------------------------------------------------
**Screenshots**

<p align="center">
  <img src="store_front/android/en-US/phone_169/01.png" alt="Dashboard - Device Connected" width="32%"/>
  <img src="store_front/android/en-US/phone_169/02.png" alt="Offline Firmware Manager" width="32%"/>
  <img src="store_front/android/en-US/phone_169/03.png" alt="Target Selection" width="32%"/>
</p>
<p align="center">
  <img src="store_front/android/en-US/phone_169/04.png" alt="Flashing Progress" width="32%"/>
  <img src="store_front/android/en-US/phone_169/05.png" alt="PWM Configuration" width="32%"/>
  <img src="store_front/android/en-US/phone_169/06.png" alt="App Settings" width="32%"/>
</p>

--------------------------------------------------------------------------------
**Documentation**

For detailed instructions and technical information, please refer to the documentation:

- **[User Guide](https://elrsmobile.com/user_guide)**: Step-by-step guide on caching firmware, connecting to your device, and flashing.
- **[Supported Hardware](https://elrsmobile.com/supported_hardware)**: Lists of explicitly tested hardware targets and binaries, and supported platforms.
- **[Technical Architecture](https://elrsmobile.com/technical_architecture)**: Details on the native Dart implementation and unified firmware assembly.
- **[Development & Auditing](https://elrsmobile.com/development)**: Information for developers regarding firmware auditing and byte-perfect matches.

--------------------------------------------------------------------------------
## 💬 Community & Support
- **Discord:** Join the [ExpressLRS Discord](https://discord.gg/expresslrs) and find me in the `#general` channel.
- **Bug Reports:** Please use the [GitHub Issue Tracker](https://github.com/wbhinton/ELRS-Mobile/issues) for technical bugs.
- **Feedback:** Feel free to open a [Discussion](https://github.com/wbhinton/ELRS-Mobile/discussions) for feature requests!

--------------------------------------------------------------------------------
*License & Attribution*
- Software License: This project is licensed under the GPLv3.
- Trademark Notice: "ExpressLRS" is a trademark of ExpressLRS LLC.
- Credits: Massive thanks to the ExpressLRS development team. The open-source nature of their Configurator, Web Flasher, and WebUI made reverse-engineering this native Flutter implementation possible.