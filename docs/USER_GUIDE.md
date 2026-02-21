# User Guide

## Overview
This application provides a comprehensive mobile interface for managing ELRS 4.0 hardware. It enables users to configure receiver (RX) and transmitter (TX) parameters, map PWM outputs, and flash firmware updates directly from a mobile device.

## Connectivity

### Device Discovery
The system utilizes a multi-stage discovery process to locate ELRS devices on the local network:
1. **mDNS Resolution**: The app attempts to resolve `elrs_rx.local` or `elrs_tx.local`.
2. **Static AP IP**: If mDNS fails, the system checks the default ELRS Access Point IP at `10.0.0.1`.
3. **Manual IP Override**: Users may specify a static IP address in the Dashboard settings. This bypasses the discovery sequence for non-standard network environments.

### Connection Resilience
The interface maintains a "last-known-good" state during transient network drops. A 30-second grace period (3 missed heartbeats) is observed before the system declares a device disconnected. A "Reconnecting..." indicator appears in the top-right corner during background recovery attempts.

## Device Configuration

### General Settings
The system provides access to core operational parameters:
- **Binding Phrase**: A unique identifier used to link the TX and RX.
- **WiFi Intervals**: Configuration for the timeout period before the device enters WiFi mode.
- **Regulatory Domain**: Selection of regional frequency profiles (e.g., FCC915, EU868).

### PWM Mapping Logic
For hardware equipped with PWM outputs, the system allows granular control over physical pins:
1. **Channel Assignment**: Assign any available CRSF channel to a specific physical output pin.
2. **Output Frequency**: Select the update rate for each pin. Supported modes include standard 50Hz–400Hz and DSHOT300 for digital ESCs.
3. **Serial Mode**: Pins may be toggled between PWM and Serial (TX/RX) modes for secondary telemetry or peripheral connections.

## Flashing & Updates

### Firmware Workflow
The flashing module automates the preparation and transmission of firmware:
1. **Target Selection**: Users select the vendor and specific hardware target.
2. **Version Selection**: The system fetches available firmware versions from the repository.
3. **Build & Flash**: The system patches the binary with local credentials and uploads via the ELRS HTTP update API.

### Credential Persistence
To streamline the update process, the application persists the following data in local storage:
- WiFi SSID
- WiFi Password
- Binding Phrase

These values are automatically applied to the firmware patcher, ensuring that updated devices reconnect to the pilot's network without manual reconfiguration.
