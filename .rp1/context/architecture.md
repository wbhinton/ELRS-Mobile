# System Architecture

**Project**: ExpressLRS Configurator
**Architecture Pattern**: Feature-First Clean Architecture with Provider-Based State Management
**Last Updated**: 2026-04-02

## High-Level Architecture

```mermaid
graph TB
    subgraph Presentation
        Splash[Splash Screen]
        Dashboard[Dashboard Screen]
        Flashing[Flashing Screen]
        Settings[Settings Screen]
        DeviceConfig[Device Settings]
        FirmwareMgr[Firmware Manager]
        Support[Support Screen]
    end

    subgraph Application
        Router[GoRouter]
        Analytics[AnalyticsService]
        TargetIp[TargetIp Provider]
    end

    subgraph Infrastructure
        localDio[localDio Provider]
        internetDio[internetDio Provider]
        NativeNet[NativeNetworkService]
        Theme[AppTheme]
    end

    subgraph External
        Aptabase[Aptabase]
        Sentry[Sentry]
        ELRS_Device[ELRS Hardware]
        AndroidAPI[Android Network API]
    end

    Router -->|navigation| Splash
    Router -->|navigation| Dashboard
    Router -->|navigation| Flashing
    Router -->|navigation| Settings
    Router -->|navigation| DeviceConfig
    Router -->|navigation| FirmwareMgr
    Router -->|navigation| Support

    Settings -->|shareAnalytics| Analytics
    Analytics -->|track events| Aptabase
    Router -->|error tracking| Sentry

    TargetIp -->|IP address| localDio
    localDio -->|HTTP POST| ELRS_Device
    localDio -->|HTTP GET| ELRS_Device
    internetDio -->|API calls| Aptabase

    NativeNet -->|bindProcessToWiFi| AndroidAPI
    Flashing -->|uses| localDio
    DeviceConfig -->|uses| localDio
```

## Architecture Patterns

### Provider-Based State Management
**Evidence**: Riverpod providers in connection_repository.dart (TargetIp), device_dio.dart (localDio, internetDio), analytics_service.dart
**Description**: Riverpod used for reactive state management with code generation (@riverpod, @Riverpod annotations)

### Repository Pattern
**Evidence**: TargetIp repository manages device IP state with logging
**Description**: Centralized state container for target device connection state

### Feature-First Architecture
**Evidence**: lib/src/features/* directories with splash, flashing, settings, dashboard, configurator, firmware_manager, support
**Description**: UI organized by feature modules containing presentation logic

### Platform Channels
**Evidence**: native_network_service.dart uses MethodChannel('org.expresslrs.elrs_mobile/network') for WiFi binding
**Description**: Native Android/iOS integration for network interface binding without OS routing

### Dual-Network Strategy
**Evidence**: device_dio.dart provides localDio (WiFi target) and internetDio (external APIs)
**Description**: Separated HTTP clients for local device communication vs internet traffic

## Component Architecture

### Presentation Layer
**Purpose**: UI screens and widgets
**Components**: splash_screen.dart, dashboard_screen.dart, flashing_screen.dart, settings_screen.dart, device_settings_screen.dart, firmware_manager_screen.dart, support_screen.dart
**Dependencies**: Application Layer

### Application Layer
**Purpose**: Business logic, providers, controllers
**Components**: router.dart, analytics_service.dart, connection_repository.dart
**Dependencies**: Infrastructure Layer

### Infrastructure Layer
**Purpose**: External integrations, networking, platform access
**Components**: device_dio.dart, native_network_service.dart, app_theme.dart
**Dependencies**: None (boundary to external)

### Domain/Data Layer
**Purpose**: Device configurations and hardware definitions
**Components**: targets.json, runtime_config_model.dart
**Dependencies**: None (data source)

### Flashing Feature Architecture

```mermaid
graph LR
    subgraph UI
        FC[FlashingController]
        FS[FlashingScreen]
    end

    subgraph Data
        FR[FirmwareRepository]
        DR[DeviceRepository]
        TR[TargetsRepository]
        RR[ReleasesRepository]
    end

    subgraph Utils
        TR2[TargetResolver]
        HCM[HardwareConfigMerger]
        UFB[UnifiedFirmwareBuilder]
        FP[FirmwarePatcher]
    end

    subgraph Storage
        FCS[FirmwareCacheService]
        PS[PersistenceService]
    end

    FC --> FS
    FC --> FR
    FC --> DR
    FC --> TR
    FC --> RR
    FC --> TR2
    FC --> HCM
    FC --> UFB
    FC --> FP
    FR --> FCS
    TR --> FCS
    DR --> FCS
```

## Data Flow

### Device Connection Flow
```mermaid
sequenceDiagram
    participant User
    participant UI as FlashingScreen
    participant CV as ConfigViewModel
    participant Discovery as DiscoveryService
    participant Dio as localDio
    participant Device as ELRS Device

    User->>UI: Select target
    UI->>CV: Check connection
    CV->>Discovery: discoverDevices()
    Discovery-->>CV: device IPs
    CV->>Dio: Update baseUrl
    Dio->>Device: GET /config
    Device-->>Dio: RuntimeConfig JSON
    Dio-->>CV: Config
    CV-->>UI: Connected
    UI->>Device: POST /update (firmware)
    Device-->>UI: Success
```

### Firmware Flashing Pipeline
```mermaid
flowchart TD
    A[User selects target] --> B[Check cache]
    B --> C{Found?}
    C -->|Yes| D[Load from cache]
    C -->|No| E[Download from Artifactory]
    E --> F[Extract firmware.zip]
    D --> G[Apply patch config]
    G --> H{Platform?}
    H -->|ESP| I[Assemble unified firmware]
    H -->|STM32| J[Binary patch with magic header]
    I --> K[Upload via localDio]
    J --> K
    K --> L[Device reboots]
    L --> M[Success]
```

## Integration Points

### External Services

| Service | Purpose | Integration Type | Details |
|---------|---------|------------------|---------|
| Aptabase Analytics | User event and analytics tracking | REST API | Aptabase Flutter SDK with app ID A-US-0489684056, configurable via user opt-in |
| Sentry | Error tracking and crash reporting | Flutter SDK | SentryNavigatorObserver integrated with GoRouter for automatic screen tracking |
| ELRS Device WebUI | Device configuration and firmware upload | HTTP REST | localDio connects to 10.0.0.1 on ELRS devices, internetDio fetches from release servers |
| Artifactory | Firmware artifact storage | HTTP | Downloads firmware.zip and hardware.zip from ELRS builds |
| GitHub | Target definitions | HTTP | Fetches targets.json from ExpressLRS/targets repository |

### Platform Channels

| Channel | Platform | Purpose | Methods |
|---------|---------|---------|---------|
| org.expresslrs.elrs_mobile/network | Android | Bind process to WiFi | bindProcessToWiFi(), unbindProcess() |
| org.expresslrs.elrs_mobile/network | iOS | No-op | N/A |

## Network Architecture

### Dual Dio Strategy

| Client | Purpose | Base URL | Timeout |
|--------|---------|----------|---------|
| localDio | Device communication | 10.0.0.1 (AP mode) or discovered IP | 10s connect, 30s receive |
| internetDio | External APIs | aptabase.app, github.com | 60s default |

### Connectivity Binding
- **Problem**: Android routes traffic based on internet availability, not WiFi association
- **Solution**: Platform channel binds process to WiFi interface via NetworkApi
- **Flow**: 
  1. User connects to ELRS device hotspot
  2. App calls `nativeNetworkService.bindProcessToWiFi()`
  3. Android API forces all HTTP traffic through WiFi even without internet
  4. After flashing, `unbindProcess()` restores normal routing

## Deployment Architecture

### Mobile Platforms
- **Android**: Native network binding via platform channel
- **iOS**: Automatic WiFi routing (no binding needed)

### Distribution
- Google Play Store (Android)
- Apple App Store (iOS)

### Build Variants
- Debug: Full logging, mock services available
- Release: Proguard/R8 minification, crash reporting enabled
