# Domain Concepts & Terminology

**Project**: ELRS (ExpressLRS) Mobile App
**Domain**: RC Model Firmware Flashing / IoT Device Management

## Core Business Concepts

### TargetDefinition
**Definition**: Represents an ELRS hardware target/device from targets.json with vendor, name, platform, frequencyType (2.4GHz/900MHz/Dual Band), deviceType (RX/TX), and config map
**Implementation**: [`lib/src/features/flashing/domain/target_definition.dart`]
**Key Properties**:
- `vendor`: Hardware manufacturer (e.g., HappyModel, BetaFPV)
- `name`: Device model identifier
- `platform`: ESP8285, ESP32, STM32, etc.
- `frequencyType`: 2.4GHz, 900MHz, or Dual Band
- `deviceType`: RX (Receiver) or TX (Transmitter)

**Business Rules**:
- Device must match firmware for correct flashing
- Dual-band devices support both 2.4GHz and 900MHz
- FirmwarePatcher dispatches to ESP or STM32 patcher based on platform

### AnalyticsService
**Definition**: Event tracking service using Aptabase SDK for telemetry. Initializes with app ID A-US-0489684056, respects shareAnalytics setting
**Implementation**: [`lib/src/core/analytics/analytics_service.dart`]
**Key Properties**:
- `shareAnalytics`: User preference controlling whether analytics events are sent. Default true, stored in SharedPreferences

**Business Rules**:
- AnalyticsService checks shareAnalytics setting before tracking events
- Initialization happens early in app lifecycle, before user opt-in
- Tracks: mDNS scans, device connections, firmware operations, settings changes

### PatchConfiguration
**Definition**: Configuration for patching firmware with bindPhrase, WiFi credentials, regulatoryDomain, UID
**Implementation**: [`lib/src/features/flashing/domain/patch_configuration.dart`]
**Relationships**:
- Uses BindingPhraseUtils to generate UID bytes from bindPhrase
- Applied to firmware before flashing

### RuntimeConfig
**Definition**: Runtime configuration retrieved from device containing ElrsSettings, ElrsOptions, and ElrsConfig
**Implementation**: [`lib/src/features/config/domain/runtime_config_model.dart`]

## Technical Concepts

### FirmwareAssembler
**Purpose**: Assembles ESP Unified Firmware with trimmed firmware + productName (128B) + luaName (16B) + options JSON (512B) + hardware layout (2048B)
**Implementation**: [`lib/src/features/flashing/utils/firmware_assembler.dart`]

### Stm32FirmwarePatcher
**Purpose**: Binary patching for STM32 firmware using magic header bytes
**Implementation**: [`lib/src/features/flashing/utils/stm32_firmware_patcher.dart`]

### Platform Channel Architecture
**Purpose**: Native WiFi binding for ELRS device communication
**Implementation**: MethodChannel 'org.expresslrs.elrs_mobile/network'
**Usage**:
```dart
// Flutter calls native WiFi binding
await channel.invokeMethod('bindProcessToWiFi', {'ip': '10.0.0.1'});
```

### mDNS Discovery
**Definition**: Multicast DNS for service discovery on local network. Used to find ELRS devices via _http._tcp
**Events Emitted**:
- mDNS Scan Started
- mDNS Fallback Triggered (when no device found in 3s, falls back to 10.0.0.1)
- mDNS Device Found (with connection_type: Access Point vs Home WiFi)
- mDNS Scan Failed (with error details)

### Firmware Operation Events
**Definition**: Analytics events for flashing operations
**Events**:
- Firmware Downloaded (target, version)
- Firmware Download Error (error)
- Firmware Flashed (target, version)
- Firmware Flash Error (errorType, error)

## Terminology Glossary

### Business Terms
- **UID Generation**: 6-byte unique identifier generated from MD5 hash of binding phrase for RF link authentication
- **Regulatory Domain**: Frequency band regulations: AU915, FCC915, EU868, IN866, AU433, EU433, US433
- **Model Match**: Feature binding receiver to specific RC model ID (0-63) for security
- **Aptabase**: Privacy-focused analytics platform (A-US-0489684056)
- **Access Point**: Connection type when device host is 10.0.0.1 (ELRS device as AP)
- **Home WiFi**: Connection type when device is on same network as app

### Technical Terms
- **Magic Header**: Signature bytes in firmware for locating configuration injection point
- **Unified Firmware**: Single firmware binary with appended configuration sections
- **Hardware Layout**: JSON configuration describing device hardware embedded in unified firmware

## Cross-References
- **Architecture**: See [architecture.md] - Clean Architecture with Riverpod
- **Modules**: See [modules.md] - Feature-based module organization
- **Patterns**: See [patterns.md] - Implementation conventions
