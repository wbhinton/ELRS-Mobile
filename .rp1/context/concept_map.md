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

### PatchConfiguration
**Definition**: Configuration for patching firmware with bindPhrase, WiFi credentials, regulatoryDomain, UID
**Implementation**: [`lib/src/features/flashing/domain/patch_configuration.dart`]
**Relationships**:
- Uses BindingPhraseUtils to generate UID bytes from bindPhrase
- Applied to firmware before flashing

### RuntimeConfig
**Definition**: Runtime configuration retrieved from device containing ElrsSettings, ElrsOptions, and ElrsConfig
**Implementation**: [`lib/src/features/config/domain/runtime_config_model.dart`]
**Key Properties**:
- `ElrsSettings`: productName, version, target, moduleType, hasSerialPins, deviceId, domain
- `ElrsOptions`: uid, wifi-ssid, wifi-password, wifi-on-interval, tlm-interval, fan-runtime, isAirport, domain
- `ElrsConfig`: modelId, forceTlm, vbind, serialProtocol, sbusFailsafe, pwm, hardware

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

### FirmwareAssembler
**Purpose**: Assembles ESP Unified Firmware with trimmed firmware + productName (128B) + luaName (16B) + options JSON (512B) + hardware layout (2048B)
**Implementation**: [`lib/src/features/flashing/utils/firmware_assembler.dart`]

### Stm32FirmwarePatcher
**Purpose**: Binary patching for STM32 firmware using magic header 0xBE, 0xEF, 0xBA, 0xBE, 0xCA, 0xFE, 0xF0, 0x0D
**Implementation**: [`lib/src/features/flashing/utils/stm32_firmware_patcher.dart`]

### TargetResolver
**Purpose**: Resolves hardware layout by extracting from hardware.zip and applying target overlay config
**Implementation**: [`lib/src/features/flashing/utils/target_resolver.dart`]

### HardwareConfigMerger
**Purpose**: Merges overlay configuration into base hardware layout (overlay values override base)
**Implementation**: [`lib/src/features/flashing/utils/hardware_config_merger.dart`]

### FrequencyValidator
**Purpose**: Validates frequency against hardware capabilities using Bit 7 of modelId as 2.4GHz capability flag
**Implementation**: [`lib/src/features/config/utils/frequency_validator.dart`]

### BindingPhraseUtils
**Purpose**: Generates 6-byte UID from binding phrase using MD5 hash of '-DMY_BINDING_PHRASE=$phrase'
**Implementation**: [`lib/src/core/utils/binding_phrase_utils.dart`]

### ValidationUtils
**Purpose**: General validation utilities for WiFi SSID (1-32 octets), password (8-63 chars), and binding phrase
**Implementation**: [`lib/src/core/utils/validation_utils.dart`]

## Terminology Glossary

### Business Terms
- **UID Generation**: 6-byte unique identifier generated from MD5 hash of binding phrase for RF link authentication
- **Regulatory Domain**: Frequency band regulations: AU915, FCC915, EU868, IN866, AU433, EU433, US433
- **Model Match**: Feature binding receiver to specific RC model ID (0-63) for security
- **PWM Mode**: Output timing protocol: 50Hz-400Hz, DSHOT300, Serial TX/RX
- **Serial Protocol**: RC telemetry protocol: CRSF, SBUS, SUMD, DJI RS Pro, MAVLink, AirPort, HoTT, Jetibox

### Technical Terms
- **Magic Header**: Signature bytes in firmware for locating configuration injection point (ESP: 0xBE, 0xEF, 0xCA, 0xFE; STM32: 0xBE, 0xEF, 0xBA, 0xBE, 0xCA, 0xFE, 0xF0, 0x0D)
- **Unified Firmware**: Single firmware binary with appended configuration sections (productName 128B, luaName 16B, options 512B, hardware layout 2048B)
- **Hardware Layout**: JSON configuration describing device hardware (GPIO pins, LED config, etc.) embedded in unified firmware
- **Lua Name**: 16-byte device identifier displayed in OpenTX Lua scripts
- **Product Name**: 128-byte human-readable device name in unified firmware
- **Flash Discriminator**: Unique identifier to prevent flashing wrong firmware version
- **Hardware Overlay**: Target-specific configuration that overrides base hardware layout from hardware.zip

## Patterns

### Magic Header Binary Patching
**Context**: Firmware flashing
**Application**: Locate signature bytes in firmware binary and inject configuration at fixed offset relative to header

### Configuration Overlay
**Context**: Hardware layout resolution
**Application**: Base hardware layout merged with target-specific overlay where overlay values override base

### UID Generation from Binding Phrase
**Context**: Device binding
**Application**: MD5 hash of '-DMY_BINDING_PHRASE=$phrase', first 6 bytes = UID

### Fixed-Size Section Appending
**Context**: Unified firmware
**Application**: Append productName (128B), luaName (16B), options JSON (512B), hardware layout (2048B) to trimmed firmware

### Hardware Capability Flag
**Context**: Frequency validation
**Application**: modelId bit 7 = 2.4GHz capability flag used as ground truth for band selection

### Platform-Specific Dispatch
**Context**: Firmware patching
**Application**: FirmwarePatcher dispatches to ESP (FirmwareAssembler) or STM32 (Stm32FirmwarePatcher) based on platform

## Cross-References
- **Architecture**: See [architecture.md] - Clean Architecture with Riverpod
- **Modules**: See [modules.md] - Feature-based module organization
- **Patterns**: See [patterns.md] - Implementation conventions
