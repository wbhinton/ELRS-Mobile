# Domain Concepts & Terminology

**Project**: ExpressLRS Configurator
**Domain**: FPV Drone RC Link Configuration - Firmware management and device configuration for ExpressLRS hardware

## Core Business Concepts

### TargetDefinition
**Definition**: Hardware target/board definition including vendor, product name, firmware identifier, platform, and device type (TX/RX)
**Implementation**: [`lib/src/features/flashing/domain/target_definition.dart`]
**Key Properties**:
- `firmware`: Firmware identifier string (e.g., "DIY_2400_RX_STM32_CCG_Nano_v0_5")
- `platform`: Hardware platform (ESP8285, ESP32, ESP32-S3, STM32)
- `deviceType`: TX (Transmitter) or RX (Receiver)
- `frequency`: 900MHz or 2400MHz based on bit 7 of modelId

**Business Rules**:
- TX devices can flash firmware but cannot configure runtime settings
- RX devices support full configuration via WebUI
- Unified targets require hardware.zip for layout configuration

### RuntimeConfig
**Definition**: Root device configuration model containing settings, options, and config sub-models fetched from device WebUI
**Implementation**: [`lib/src/features/config/domain/runtime_config_model.dart`]
**Key Properties**:
- `settings`: Hardware/connection settings (wifi mode, ssid, bind phrase hash, UID, domain)
- `options`: WiFi and telemetry options (power, telemetry ratio, switch modes)
- `config`: Protocol/channel configuration (model match, PWM modes, serial protocols)

**Business Rules**:
- Config is read-only unless device is in WiFi mode
- UID derived from MD5 hash of bind phrase (6 bytes)
- Domain restrictions depend on regulatory region (AU915, FCC915, EU868, etc.)

### PatchConfiguration
**Definition**: Configuration data to be patched into firmware: bind phrase, WiFi credentials, regulatory domain, UID
**Implementation**: [`lib/src/features/flashing/domain/patch_configuration.dart`]
**Key Properties**:
- `bindPhrase`: User-provided phrase for generating UID
- `wifiSsid`: WiFi network name
- `wifiPassword`: WiFi password
- `regulatoryDomain`: Legal frequency restrictions (AU915, FCC915, EU868, IN866, AU433, EU433, US433)

### FirmwarePatcher
**Definition**: Orchestrates firmware patching by platform type (ESP vs STM32), delegates to specialized patchers
**Implementation**: [`lib/src/features/flashing/application/firmware_patcher.dart`]
**Responsibilities**:
- Detects platform type from target definition
- Routes to Stm32FirmwarePatcher for STM32 binaries
- Uses FirmwareAssembler for ESP unified builds

### FirmwareAssembler
**Definition**: Assembles EspUnified firmware binary with trimmed firmware, product name, Lua name, options JSON, and hardware layout JSON
**Implementation**: [`lib/src/features/flashing/utils/firmware_assembler.dart`]
**Key Operations**:
- Trims firmware to actual data end (skipping 0x00/0xFF padding)
- Appends product name (128 bytes), lua name (16 bytes)
- Appends options JSON (512 bytes) with uid, wifi credentials
- Appends hardware layout JSON (2048 bytes)

### Stm32FirmwarePatcher
**Definition**: Patches STM32 firmware by locating magic header (0xBEEFBA..) and writing UID and domain at correct offset
**Implementation**: [`lib/src/features/flashing/utils/stm32_firmware_patcher.dart`]
**Key Operations**:
- Locates 8-byte magic header sequence (0xBEEFBA..)
- Writes 6-byte UID at offset + 0x10
- Writes 1-byte domain at offset + 0x16

## Technical Concepts

### Device Discovery & Connection
**Purpose**: Find and connect to ELRS devices on local network
**Implementation**: [`lib/src/core/networking/discovery_service.dart`], [`lib/src/core/networking/connectivity_service.dart`]
**Usage Flow**:
```dart
// 1. mDNS discovery for _http._tcp services
final devices = await discoveryService.discoverDevices();

// 2. Fallback to AP mode default IP
final ip = devices.firstOrNull ?? '10.0.0.1';

// 3. Bind app process to WiFi interface (Android)
await nativeNetworkService.bindProcessToWiFi();

// 4. All HTTP traffic now routes to ELRS device
final config = await deviceConfigService.fetchConfig();
```

### Firmware Cache Strategy
**Purpose**: Enable offline operation with pre-downloaded firmware
**Implementation**: [`lib/src/core/storage/firmware_cache_service.dart`]
**Strategy**: LRU eviction maintaining maxVersions per target
**Storage**: Firmware zips extracted to app cache directory
**Offline Support**: Cached target JSON and hardware layouts available without network

### Network Binding (Android)
**Purpose**: Force app traffic through WiFi interface when device provides hotspot
**Implementation**: [`lib/src/core/networking/native_network_service.dart`]
**Integration**: Platform channel to Android NetworkApi.bindProcessToNetwork()
**iOS**: No-op implementation (iOS handles this automatically)

## Terminology Glossary

### Business Terms
- **ExpressLRS (ELRS)**: Open-source RC link protocol for FPV drones operating at 900MHz or 2.4GHz
- **Bind Phrase**: User-provided phrase that generates a 6-byte UID via MD5 hash for device binding
- **UID**: 6-byte unique identifier derived from MD5 of bind phrase, stored in firmware
- **Regulatory Domain**: Legal frequency restrictions mapped to integers (AU915, FCC915, EU868, IN866, AU433, EU433, US433)

### Technical Terms
- **PWM Modes**: Pulse width modulation output modes: 50Hz-400Hz, On/Off, DSHOT300, Serial TX/RX
- **Serial Protocols**: RC protocol encodings: CRSF, SBUS, SUMD, DJI RS Pro, MAVLink, AirPort, HoTT, Jetibox, M-Link, G-Link, Serial VTX
- **AirPort Mode**: Passthrough mode for serial communication through ELRS link
- **Magic Header**: 8-byte STM32 header sequence (0xBEEFBA..) used to locate patching offset
- **EspUnified**: Standard ESP firmware binary format with embedded product name, Lua name, options JSON, and hardware layout JSON
- **Lua Script**: Embedded Lua script on device for in-field configuration
- **Flash Discriminator**: Timestamp-based value to differentiate firmware flashes
- **mDNS**: Multicast DNS for service discovery (_http._tcp) to find devices on local network
- **WebUI**: Device's embedded web server for HTTP-based configuration access

## Concept Boundaries

| Context | Scope | Concepts | Boundaries |
|---------|-------|----------|------------|
| Firmware Management | Flashing feature | FirmwarePatcher, FirmwareAssembler, Stm32FirmwarePatcher, FirmwareCacheService, TargetDefinition | Owns binary patching and assembly; does not handle device communication |
| Device Configuration | Config feature | RuntimeConfig, DeviceConfigService, ElrsMappings | Owns device communication and runtime config; does not handle firmware storage |
| Network Connectivity | Core networking | ConnectivityService, DiscoveryService | Handles interface binding and mDNS; abstracted from protocol specifics |
| Secure Storage | Core storage | PersistenceService, FirmwareCacheService | Handles encrypted credentials and file caching; does not handle firmware content processing |

## Cross-Cutting Concerns

| Concern | Approach | Affected Areas |
|---------|----------|----------------|
| Platform Abstraction | Platform-specific dispatch (ESP vs STM32) with unified patch interface | firmware patching, firmware assembly, binary format handling |
| Offline Operation | Cached target JSON and firmware zips enable full operation without network | device discovery fallback, firmware cache, target definitions |
| Security | Encrypted storage for credentials (bind phrase, WiFi), one-time plaintext migration with cleanup | persistence service, configuration UI |
