# ExpressLRS Manager

> [!IMPORTANT]
> **Work in Progress**: This project is currently under active development and should be considered an alpha/experimental tool.

ExpressLRS Manager is a modern, cross-platform Flutter application designed to simplify the management, configuration, and flashing of ExpressLRS hardware. It aims to provide a seamless experience for updating firmware and managing device settings directly from your desktop or mobile device.

## Core Features

- **Advanced WiFi Flashing**: Flashing for ESP32 and ESP8285 platforms via WiFi OTA.
- **Unified Firmware Assembly**: Dynamically assembles firmware payloads with user-specific options (Binding Phrase, WiFi SSID/Password) and hardware layouts.
- **Target Management**: Advanced parsing and resolution of ExpressLRS targets and hardware configuration files.
- **Device Configurator**: Real-time fetching and updating of device parameters such as binding phrases and UID generation. (work in progress)
- **Network Discovery**: Automatic detection of ELRS devices on your network using mDNS (NSD).


## Credits

This project heavily leverages logic and patterns from the official [ExpressLRS Webflasher](https://github.com/ExpressLRS/web-flasher) and [ExpressLRS Configurator](https://github.com/ExpressLRS/ExpressLRS-Configurator) projects. Without the incredible work of the ExpressLRS team and contributors, this application would not be possible.

---
*Created and maintained for the FPV community.*
