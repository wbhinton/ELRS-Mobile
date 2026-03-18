---
title: User Guide
slug: user_guide
---

## Overview
This application provides a comprehensive mobile interface for managing ELRS 4.0 hardware. It enables users to configure receiver (RX) and transmitter (TX) parameters, map PWM outputs, and flash firmware updates directly from a mobile device.

## Connectivity

### Device Discovery
The app uses a robust multi-stage discovery sequence to find your hardware:
1. **mDNS Resolution**: The primary method. The app scans for `elrs_rx.local` or `elrs_tx.local` using standard network discovery protocols.
2. **Static AP Fallback**: If mDNS is blocked by the network, the app checks the official ELRS access point IP (`10.0.0.1`).
3. **Manual IP Override**: For complex mesh networks or custom VPNs, you can manually enter an IP address in the Dashboard settings.

### Forced Network Binding (Mobile Only)
Modern smartphones often discard Wi-Fi connections that don't have internet access (like the hotspot on your ELRS receiver). ELRS Mobile includes a native "Forced Routing" layer that forces the OS to stick to the hardware connection, ensuring 100% reliable discovery in the field.

---

## Device Configuration

### 4.x Feature Support
ELRS Mobile is fully compatible with ExpressLRS 4.0 architecture, supporting:
- **Binding Phrase**: Standard MD5-based UID generation.
- **Regulatory Domains**: Regional frequency profiles (FCC915, EU868, etc.).
- **PWM Output Mapping**: Direct control over individual pin timer frequencies and modes.
- **Model Match**: Prevent accidental control of the wrong aircraft.

---

## Flashing & Updates

### Universal Firmware Pipeline
The flashing module automates the entire preparation process:
1. **Target Identification**: Select your vendor and hardware model using the cascading dropdowns.
2. **Offline Caching**: All firmware is pre-downloaded and stored on your phone via the [**Firmware Manager**](/guides/usage_instructions).
3. **On-Device Assembly**: The app builds the final binary locally—no cloud compiler or internet required at the field.

---

## Expert Mode & Auditing
Within the Settings menu, users can enable **Expert Mode**. This advanced feature allows you to save the assembled firmware binary directly to your device for auditing or manual flashing via FTDI/STLink.

For developers looking to verify the integrity of these binaries, see our [**Firmware Validation Guide**](/guides/firmware-validation).
