## [v1.0.43] - 2026-08-31

### New Features

*   **Quick Language Selection:** Added a dedicated language button in the Settings screen top navigation bar for immediate access to language switching across all 18 supported languages.
*   **Norwegian Language Support:** Added full Norwegian (Norsk Bokmål) localization support across the app UI, in-app guides, and website.

### Improvements

*   **Always Up-to-Date Hardware Support:** The app automatically syncs internal target definitions with upstream ExpressLRS releases.
*   **Enhanced Privacy & Experience:** Streamlined core functionality and improved reliability during firmware assembly and flashing.
*   **Translation Pipeline:** Enhanced automated translation workflows and local secret management.

---

## [v1.0.43-rc1] - 2026-08-17

### ExpressLRS Mobile App Changelog

#### Improvements

*   **Enhanced Privacy and Streamlined Experience:** We've removed internal developer features and telemetry collection. This change means the app no longer sends usage data, enhancing your privacy, and focuses the app on core functionality for a cleaner experience.
*   **Always Up-to-Date Hardware Support:** The app now automatically updates its internal list of supported ExpressLRS hardware and firmware targets directly from the official sources. This ensures that you always have access to the very latest options for flashing your devices without needing to wait for a new app version from the app store.

---

## [v1.0.42] - 2026-08-12

### New Features

*   **Support Link:** Added a Ko-fi support link in the Settings screen ("About & Legal" category) to allow users to support the development of the application.
*   **Localization:** Auto-translated support link labels across all supported languages (cs, de, es, fr, id, it, ja, ko, nl, pl, pt, ru, sv, th, uk, zh).

---

## [v1.0.41] - 2026-07-20

## ExpressLRS Mobile App - Changelog

We're excited to bring you a new update packed with features to make configuring and flashing your ExpressLRS hardware even easier and more reliable!

### New Features

*   **Configuration Profiles:** You can now create and save different "Flashing Profiles" for your ExpressLRS devices. This allows you to quickly switch between various settings and firmware configurations for different setups without having to re-enter them every time.
*   **Automatic Target Selection:** The app can now intelligently detect your connected ExpressLRS hardware and automatically suggest the correct target firmware. This makes the flashing process simpler and significantly reduces the chance of selecting the wrong target.
*   **Offline Firmware Management (Expert Mode):** For advanced users, you can now download firmware definition files and build firmware locally on your device, even without an active internet connection. This is perfect for flashing in the field or in areas with poor connectivity.
*   **Wi-Fi Hotspot Interval Control:** You can now directly configure how long your ExpressLRS device's Wi-Fi hotspot stays active after power-up, right within the app's settings. This customized setting is also saved as part of your new Configuration Profiles.

### Improvements

*   **Smarter Input Validation:** When entering settings or preparing to flash, the app now provides clearer feedback and error messages if your input is incorrect, helping you avoid mistakes before they become a problem.
*   **Enhanced Target Mismatch Warnings:** If the app detects a mismatch between your selected target and your hardware, the warning message is now clearer and easier to understand. Firmware file names are also more consistently formatted for better identification.
*   **Faster Firmware Building:** The app now builds firmware more efficiently, caching necessary files to avoid redundant processing. This means less waiting for you, especially if you need to retry a flashing attempt.
*   **Always Up-to-Date Targets:** The app now automatically receives the latest ExpressLRS hardware target definitions, ensuring compatibility with new devices and improved reliability when flashing.

### Bug Fixes

*   **Stable Hardware Communication:** We've made the communication with your ExpressLRS hardware much more stable, preventing crashes and improving overall reliability during configuration and flashing.
*   **Reliable Wi-Fi Disconnection Detection:** The app now correctly recognizes when you've disconnected from your device's Wi-Fi hotspot. This means you can seamlessly switch to your home Wi-Fi for firmware downloads without the app getting stuck offline.
*   **Prevented App Crashes:** Fixed an issue where the app could sometimes crash when interacting with certain Android system features or plugins, leading to a more stable overall experience.
*   **Offline Download Fixes:** Addressed issues that sometimes prevented firmware from being downloaded successfully when you were offline.
