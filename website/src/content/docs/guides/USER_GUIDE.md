---
title: User Guide
slug: user_guide
sidebar:
  order: 1
---

## Overview
This application provides a comprehensive mobile interface for managing ExpressLRS hardware. It enables users to configure receiver (RX) and transmitter (TX) parameters, map PWM outputs, and flash firmware updates directly from a mobile device.

---

## Installation

### Official App Stores

#### [Android](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile)
Install from Google Play

<a href="https://play.google.com/store/apps/details?id=io.datarx.elrsmobile" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Get it on Google Play</a>

#### [iOS](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
Install from the App Store

<a href="https://apps.apple.com/us/app/elrs-mobile/id6760490014" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Download on App Store</a>

### Alternative Installation

#### GitHub Store
Ideal for users who prefer an alternative app store experience.

<a href="https://github.com/OpenHub-Store/Github-Store" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Download on GitHub Store</a>

### Manual Installation
For power users or those who prefer manual management, visit our [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases) page for the latest `.apk` files.

---

## 🚀 Quick Start: Flashing Your First Device

### Phase 1: Caching Firmware (Do this at home)
1. Open the app and navigate to the **Firmware Manager**.
2. Tap the download icon next to the latest stable release.
3. The app will download and securely cache the required target and hardware definitions for offline use.

### Phase 2: Connecting to Your Device
1. Power on your ExpressLRS Receiver (RX) or Transmitter (TX).
2. Wait 60 seconds (or your configured interval) for the device to enter Wi-Fi Hotspot Mode (rapid blinking LED).
3. Connect your phone's Wi-Fi to the **ExpressLRS RX** or **ExpressLRS TX** network (Password: `expresslrs`).
4. Open the app. The Dashboard will automatically scan the network using mDNS and connect to the device.

### Phase 3: Flashing Firmware
1. From the Dashboard, select **Flash Device**.
2. **Select your Hardware:** Use the cascading dropdowns to select your Device Type, Vendor, Frequency, and Target.
3. **Configure Options:** Set your custom Binding Phrase, Wi-Fi credentials, and Regulatory Domain.
4. Tap **FLASH**. The app will assemble the binary locally and push it to the device.

---

## Technical Details

### Connectivity & Discovery
The app uses a robust multi-stage discovery sequence to find your hardware:
1. **mDNS Resolution**: The primary method. The app scans for `elrs_rx.local` or `elrs_tx.local`.
2. **Static AP Fallback**: If mDNS is blocked, the app checks the official ELRS access point IP (`10.0.0.1`).
3. **Manual IP Override**: For complex networks, you can manually enter an IP address in Settings.

**Forced Network Binding**: Modern smartphones often discard Wi-Fi connections without internet. ELRS Mobile includes a native "Forced Routing" layer that forces the OS to stick to the hardware connection, ensuring 100% reliable discovery in the field.


---

## Expert Mode & Auditing
Within the Settings menu, users can enable **Expert Mode**. This allows you to save the assembled firmware binary directly to your device for auditing or manual flashing via FTDI.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">STM32 Hardware Handling</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    While ELRS Mobile can assemble and patch firmware for STM32 targets (up to ELRS v3.x), these devices do not support Over-The-Air (OTA) flashing via Wi-Fi. If you select an STM32 target, the app will allow you to build and save the binary locally so you can flash it manually using a PC via STLink or Betaflight Passthrough.
  </p>
</div>

For developers looking to verify the integrity of these binaries, see our [**Firmware Validation Guide**](/guides/firmware-validation).
