# Supported Hardware

## Supported Platforms
- **Supported:** All ESP8285, ESP32, ESP32-C3, and ESP32-S3 Wi-Fi capable receivers and transmitters.
- **Legacy Support (STM32):** Hardware using STM32 chips (e.g. FrSky R9, early Ghost) is supported for **Binary Building only**.
    - **Expert Mode Required:** These targets are hidden by default and require enabling **Expert Mode** in Settings.
    - **No OTA Support:** STM32 hardware does not support Wi-Fi OTA flashing via the mobile app. You must build the binary in-app and flash manually via STLink or Betaflight Passthrough.
    - **Version Compatibility:** STM32 targets are only compatible with ExpressLRS **v3.x.x** and older. Firmware v4.0.0 and above does not support STM32.

## Tested Hardware
The following hardware targets have been explicitly tested with ELRS Mobile:
- BETAFPV SuperP 14Ch 900MHz RX
- BETAFPV PWM 2.4GHz RX
- BETAFPV SuperP 14Ch 2.4GHz RX
- RadioMaster XR1 Dual Band RX
- RadioMaster XR4 Dual Band True Diversity RX
- HappyModel EP Dual 2.4GHz RX

## Tested Binaries
The internal firmware assembler has been functionally verified against the official ExpressLRS compiler outputs for the following targets:
- BETAFPV 2.4GHz Micro TX
- BETAFPV PWM 2.4GHz RX
- BETAFPV SuperP 14Ch 2.4GHz RX
- Foxeer 2.4Ghz RX
- GEPRC C3 900/2400 Gemini Xrossband RX
- HappyModel AIO 2.4GHz RX+VTX
- HappyModel EP1/EP2 2.4GHz RX
- HappyModel EP Dual 2.4GHz RX
- HappyModel ES900 TX
- RadioMaster ER8 2.4GHz Diversity+8xPWM RX
- RadioMaster Nomad 2.4/900 TX
- RadioMaster Pocket Internal 2.4GHz TX
- RadioMaster XR4 Dual Band True Diversity RX
- Radiomaster Nexus-XR True Diversity 2.4GHz RX
- Squid Stick dongle V2
