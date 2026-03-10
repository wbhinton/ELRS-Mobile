# Domain Concepts & Terminology

**Project**: ELRS (ExpressLRS) Mobile App
**Domain**: RC Model Firmware Flashing & Configuration

## Core Business Concepts

### TargetDefinition
**Definition**: Represents an ELRS hardware target/device from targets.json with vendor, name, platform, frequencyType (2.4GHz/900MHz/Dual Band), deviceType (RX/TX), and config map
**Implementation**: [`lib/src/features/flashing/domain/target_definition.dart`]
**Key Properties**:
- vendor: Hardware manufacturer (e.g., HappyModel, BetaFPV)
- name: Device model identifier
- platform: ESP8285, ESP32, STM32, etc.
- frequencyType: 2.4GHz, 900MHz, or Dual Band
- deviceType: RX (Receiver) or TX (Transmitter)

**Business Rules**:
- Device must match firmware for correct flashing
- Dual-band devices support both 2.4GHz and 900MHz

### PatchConfiguration
**Definition**: Configuration for patching firmware with bindPhrase, WiFi credentials, regulatoryDomain, and UID
**Implementation**: [`lib/src/features/flashing/domain/patch_configuration.dart`]
**Relationships**:
- Uses BindingPhraseUtils to generate UID bytes
- Applied to firmware before flashing

### RuntimeConfig
**Definition**: Runtime configuration retrieved from device containing ElrsSettings, ElrsOptions, and ElrsConfig
**Implementation**: [`lib/src/features/config/domain/runtime_config_model.dart`]
**Key Properties**:
- ElrsSettings: productName, version, target, moduleType, hasSerialPins, deviceId, domain
- ElrsOptions: uid, wifi-ssid, wifi-password, wifi-on-interval, tlm-interval, fan-runtime, isAirport, domain
- ElrsConfig: modelId, forceTlm, vbind, serialProtocol, sbusFailsafe, pwm, hardware

### FirmwarePatcher
**Definition**: Patches ESP firmware binaries with magic header injection for UID
**Implementation**: [`lib/src/features/flashing/application/firmware_patcher.dart`]
**Variants**:
- ESP: Uses FirmwareAssembler append-based approach
- STM32: Uses Stm32FirmwarePatcher binary patching

### UnifiedFirmwareBuilder
**Definition**: Generic unified firmware builder that appends configuration sections to base firmware
**Implementation**: [`lib/src/features/flashing/utils/unified_firmware_builder.dart`]
**Process**: Trim firmware, append productName (128B), luaName (16B), options JSON (512B), hardware layout (2048B)

## Technical Concepts

### UID Generation
**Purpose**: Generate unique 6-byte identifier from binding phrase
**Implementation**: [`lib/src/features/flashing/utils/firmware_assembler.dart`]
**Usage**:
```dart
// MD5 hash of '-DMY_BINDING_PHRASE="$phrase"', take first 6 bytes
```

### Magic Header Binary Patching
**Purpose**: Locate signature bytes in firmware for injecting configuration
**ESP Header**: 0xBE, 0xEF, 0xCA, 0xFE
**STM32 Header**: 0xBE, 0xEF, 0xBA, 0xBE, 0xCA, 0xFE, 0xF0, 0x0D
**Implementation**: [`lib/src/features/flashing/utils/stm32_firmware_patcher.dart`]

### mDNS Device Discovery
**Purpose**: Find ELRS devices on local network via bonjour/mDNS
**Implementation**: [`lib/src/core/networking/discovery_service.dart`]
**Service Type**: `_http._tcp`

### Platform Channel WiFi Binding
**Purpose**: Bind app process to WiFi interface to prevent cellular fallback
**Implementation**: [`lib/src/core/networking/native_network_service.dart`]
**Platform**: iOS (NetworkExtension), Android (VPNService)

## Terminology Glossary

### Business Terms
- **Binding Phrase**: User-provided passphrase converted to UID for RF link authentication
- **Regulatory Domain**: Frequency band regulations: FCC (915MHz), EU868/EU_LBT (868MHz), AU915, IN866, AU433, US433
- **Model Match**: Feature binding receiver to specific RC model ID (0-63)
- **PWM Mode**: Output timing protocol: 50Hz-400Hz, DSHOT300, Serial TX/RX
- **Serial Protocol**: RC telemetry protocol: CRSF, SBUS, SUMD, DJI RS Pro, MAVLink, AirPort, HoTT, Jetibox

### Technical Terms
- **Lua Name**: 16-byte device identifier displayed in OpenTX Lua scripts
- **Product Name**: 128-byte human-readable device name
- **Flash Discriminator**: Unique identifier to prevent flashing wrong firmware version
- **Unified Firmware**: Single firmware binary with appended configuration sections

## Cross-References
- **Architecture**: See [architecture.md] - Clean Architecture with Riverpod
- **Data Layer**: See [modules.md] - Repository pattern for device/firmware/targets
- **Patterns**: See [patterns.md] - Freezed immutable states, async/await
