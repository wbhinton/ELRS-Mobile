---
title: Technical Specification
slug: technical_spec
sidebar:
  order: 5
---

## Architecture Overview

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Design Principle</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    The application is built using Flutter and leverages the <strong>Riverpod</strong> state management framework. It interacts with ELRS hardware via a RESTful API exposed by the device's onboard WiFi module, ensuring low-latency communication and real-time state synchronization.
  </p>
</div>

## Data Layer

### API Endpoints
The system communicates with the hardware using the following HTTP endpoints:

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/config` | Retrieves the current device configuration in JSON format. |
| `POST` | `/options.json` | Updates modifiable runtime options (SSID, Password, etc.). |
| `POST` | `/config` | Updates core hardware parameters and PWM mappings. |
| `POST` | `/reboot` | Triggers a hardware reset to apply changes. |

### JSON Schema
The `RuntimeConfig` model leverages the ELRS 4.x structure, which separates parameters into three primary nodes:
- `settings`: Read-only hardware identifiers and version strings.
- `options`: Modifiable user preferences and network credentials.
- `config`: Low-level hardware configurations (Protocols, PWM Arrays).

Example JSON structure:
```json
{
  "product_name": "Test RX",
  "settings": {
    "version": "1.0.0",
    "module-type": "RX"
  },
  "options": {
    "bindPhrase": "example",
    "wifi-ssid": "SSID",
    "domain": 1
  },
  "config": {
    "serial-protocol": 0,
    "pwm": [
      {"channel": 0, "mode": 5}
    ]
  }
}
```

## State Management
The system employs a reactive architecture:
- **`ConfigViewModel`**: Manages the live connection state, heartbeat logic, and IP discovery.
- **`DeviceEditorViewModel`**: Houses the draft state of a device's configuration, enabling multi-step edits with final "save/cancel" logic.
- **`FlashingController`**: Orchestrates firmware downloads, local binary patching, and the XH-over-HTTP upload process.

## Mapping Layer
The following tables define the mapping between integer identifiers used in the API and their human-readable equivalents.

### Regulatory Domains
| ID | Label | Description |
| :--- | :--- | :--- |
| 0 | AU915 | Australia/New Zealand 915MHz |
| 1 | FCC915 | North American 915MHz |
| 2 | EU868 | European 868MHz |
| 3 | IN866 | Indian 866MHz |
| 4 | AU433 | Australia 433MHz |
| 5 | EU433 | European 433MHz |
| 6 | US433 | North American 433MHz |
| 7 | US433-Wide | North American Wide 433MHz |


## Advanced Mappings

### VBind (Binding Storage)
Determines how the binding phrase is stored on the device.
- **0: Persistent**: Saved to flash memory (standard).
- **1: Volatile**: Cleared on power cycle.
- **2: Returnable**: Used for loaner gear.
- **3: Administered**: Used in multi-pilot fleet environments.


## Persistence Layer
The system implements a dual-layer persistence strategy:
- **`SharedPreferences`**: Utilized via `PersistenceService` for non-sensitive data such as WiFi SSIDs and general app preferences.
- **`FlutterSecureStorage`**: Used for sensitive data, including Binding Phrases and WiFi Passwords, ensuring encryption at the OS level.
