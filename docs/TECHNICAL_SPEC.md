# Technical Specification

## Architecture Overview
The application is built using Flutter and leverages the Riverpod state management framework. It interacts with ELRS hardware via a RESTful API exposed by the device's onboard WiFi module.

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
- **`FlashingController`**: Orchestrates firmware downloads, local binary patching, and the XH-over-HTTP upload process.

## Mapping Layer
`ElrsMappings.domains900` maps the 900 MHz regulatory domain index used in the API to its human-readable label:

| ID | Label |
| :--- | :--- |
| 0 | AU915 |
| 1 | FCC915 |
| 2 | EU868 |
| 3 | IN866 |
| 4 | AU433 |
| 5 | EU433 |
| 6 | US433 |
| 7 | US433-Wide |

## Persistence Layer
The system implements a dual-layer persistence strategy:
- **`SharedPreferences`**: Utilized via `PersistenceService` for non-sensitive data such as WiFi SSIDs and general app preferences.
- **`FlutterSecureStorage`**: Used for sensitive data, including Binding Phrases and WiFi Passwords, ensuring encryption at the OS level.
