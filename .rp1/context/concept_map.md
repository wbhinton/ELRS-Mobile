# Domain Concepts & Terminology

**Project**: ELRS Mobile
**Domain**: Firmware Flashing & Device Configuration (RC Hobby / FPV)

## Core Business Concepts

### NativeNetworkService
**Definition**: Platform channel service that binds the app process to WiFi interface to prevent OS from routing traffic to 10.0.0.1 over cellular
**Implementation**: [`lib/src/core/networking/native_network_service.dart`]
**Key Properties**:
- Platform channel: `org.expresslrs.elrs_mobile/network`
- Cross-platform: iOS stub (returns early), Android full implementation

**Business Rules**:
- On iOS: No-op (iOS doesn't need explicit binding)
- On Android: Calls native `bindProcessToWiFi` to force WiFi routing

### Process Binding
**Definition**: OS-level network interface binding ensuring traffic to ELRS devices routes over WiFi instead of cellular
**Relationships**:
- Uses MethodChannel for native API calls
- Ensures reliable device discovery and flashing

### ConfigViewModel
**Definition**: Manages live connection state, heartbeat logic, and IP discovery for device communication
**Relationships**:
- Manages RuntimeConfig state
- Heartbeat at 10-second intervals with 30-second grace period

### FlashingController
**Definition**: Orchestrates firmware downloads, local binary patching, and XH-over-HTTP upload process
**Relationships**:
- Uses FirmwareAssembler for binary preparation
- Coordinates with ConnectivityService for network binding
- Checks device connection via ConfigViewModel before flashing

### Device Discovery
**Definition**: Multi-stage process: mDNS resolution → Static AP IP fallback → Manual IP override
**Business Rules**:
- Hotspot mode detection via rapid LED blinking
- Grace period recovery: 3 missed heartbeats (30s) before disconnect

### Version Caching
**Definition**: Firmware versions displayed only from locally cached files
**Implementation**: [`lib/src/features/flashing/presentation/widgets/version_selector.dart`]
**Business Rules**:
- Dropdown shows only versions present in `cachedVersions.value`
- Empty cache navigates user to Firmware Manager

## Technical Concepts

### Local-First Firmware Assembly
**Purpose**: App builds firmware binaries locally on-device rather than relying on remote cloud compilers
**Implementation**: [`lib/` - FirmwareAssembler]
**Usage Examples**:
```dart
// Extract base firmware, patch with user config, generate target-specific binary
final payload = await firmwareAssembler.assemble(target, config, bindPhrase);
```

### OTA (Over-The-Air) Flashing
**Purpose**: Wireless firmware transmission directly to ELRS device via XH-over-HTTP protocol
**Usage Examples**:
```dart
// HTTP-based firmware upload to device
await deviceRepo.flashFirmware(payload, targetIP);
```

### Dual-Layer Persistence
**Purpose**: SharedPreferences for non-sensitive data + FlutterSecureStorage for encrypted credentials
**Implementation**: [`lib/src/core/storage/`]
**Usage Examples**:
- Binding phrases stored encrypted
- WiFi SSIDs/passwords stored encrypted
- Regulatory domain defaults in SharedPreferences

### Multi-tier Observability
**Purpose**: Privacy-first analytics strategy with opt-in usage tracking and real-time error monitoring
**Implementation**: 
- Aptabase for feature usage insights
- Sentry for runtime exception monitoring

## Terminology Glossary

### Business Terms
- **PWM Modes**: Pulse Width Modulation output modes: 50Hz, 400Hz, DSHOT300, Serial TX, Serial RX
- **Serial Protocols**: Communication protocols: CRSF (0), SBUS (1), MAVLink (4), AirPort (5)
- **Expert Mode**: Allows saving assembled firmware binary to local storage for auditing/sharing
- **UID Generation**: 6-byte unique identifier from binding phrase MD5 for RF link authentication

### Technical Terms
- **XH-over-HTTP**: HTTP-based firmware upload protocol used by ELRS devices
- **Firmware Caching**: Pre-downloading firmware archives for offline flashing capability
- **Heartbeat**: Periodic connection check between app and device (10-second intervals)
- **Hotspot Mode**: WiFi mode on ELRS device indicated by rapid LED blinking
- **JSON Minification**: Byte-offset differences due to dense vs. spaced JSON (functionally identical)

## Cross-References
- **Firmware Pipeline**: See [architecture.md#firmware-pipeline]
- **Network Binding**: See [modules.md#core-networking]
- **State Management**: See [patterns.md#state-management]
