---
title: Usage Instructions
slug: usage_instructions
---

# How to Use ELRS Mobile

## Phase 1: Caching Firmware (Do this at home)
1. Open the app and navigate to the Firmware Manager.
2. Tap the download icon next to the latest stable release (e.g., 3.4.0).
3. The app will download and securely cache the required target and hardware definitions for offline use.

## Phase 2: Connecting to Your Device
1. Power on your ExpressLRS Receiver (RX) or Transmitter (TX).
2. Wait 60 seconds (or your configured interval) for the device to enter Wi-Fi Hotspot Mode (rapid blinking LED).
3. Connect your phone's Wi-Fi to the ExpressLRS RX or ExpressLRS TX network (Password: `expresslrs`).
4. Open the app. The Dashboard will automatically scan the network using mDNS and connect to the device, displaying its current firmware version and hardware target.

## Phase 3: Flashing Firmware
1. From the Dashboard, select **Flash Device**.
2. **Select your Hardware:** Use the cascading dropdowns to select your Device Type (e.g., RX), Vendor (e.g., RadioMaster), Frequency (e.g., 2.4GHz), and Target.
3. **Configure Options:** Set your custom Binding Phrase, Wi-Fi credentials, and Regulatory Domain.
4. Tap **FLASH**. The app will assemble the binary and push it to the device. Wait for the success confirmation and for the LED on your device to resume blinking before unplugging!
