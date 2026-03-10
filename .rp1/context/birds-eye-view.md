# ELRS (ExpressLRS) Mobile App — Bird's-Eye View

## 1) Summary

ELRS (ExpressLRS) Mobile App is a Flutter application for flashing ExpressLRS firmware to RC model receivers and transmitters. Users select hardware targets, download firmware, patch binaries with custom configuration (binding phrase, WiFi credentials), and flash devices over WiFi.

- **Domain**: RC Model Firmware Management • **Tech Stack**: Flutter, Dart, Riverpod, go_router, freezed, dio
- **Architecture**: Clean Architecture with Riverpod State Management

## 2) System Context

The app interacts with ELRS hardware devices on the local network, downloads firmware from external services, and stores user configuration locally. It discovers devices via mDNS and binds to WiFi to maintain connectivity during flashing.

```mermaid
flowchart LR
    User[User]
    App[ELRS Mobile App]
    WiFi[WiFi Network]
    Device[ELRS Hardware<br/>RX/TX]
    Artifactory[ExpressLRS<br/>Artifactory]
    GitHub[GitHub<br/>Releases]
    
    User -->|interacts| App
    App -->|mDNS discovery| Device
    App -->|HTTP upload| Device
    App -->|download firmware| Artifactory
    App -->|fetch targets| GitHub
    App -->|bind WiFi| WiFi
```

## 3) Architecture Overview (components & layers)

The app follows Clean Architecture with three layers: Presentation (Flutter widgets + go_router), Feature Layer (Riverpod providers + controllers), and Core Infrastructure (networking, storage, discovery).

```mermaid
flowchart TB
    subgraph Presentation
        UI[Flutter Widgets]
        Router[go_router]
    end
    
    subgraph Feature_Layer
        TP[TargetsProvider]
        RR[ReleasesRepository]
        FC[FlashingController]
    end
    
    subgraph Core_Infrastructure
        DS[DiscoveryService]
        CS[ConnectivityService]
        PS[PersistenceService]
        FCS[FirmwareCacheService]
    end
    
    UI --> Router
    Router --> TP
    Router --> FC
    TP --> FCS
    FC --> DS
    FC --> CS
```

## 4) Module & Package Relationships

The codebase is organized into `core/` (shared infrastructure) and `features/` (domain-specific modules). The flashing module is the most complex, depending on storage, networking, and settings features.

```mermaid
flowchart TD
    App[app.dart] --> Router[router.dart]
    App --> Settings[features/settings]
    App --> Updates[features/updates]
    App --> Networking[core/networking]
    
    Dashboard --> Settings
    Dashboard --> Flashing
    Dashboard --> Configurator
    Dashboard --> FirmwareManager
    
    Flashing --> Storage[core/storage]
    Flashing --> Networking
    Flashing --> Settings
    
    Config --> Networking
    Config --> Storage
    Config --> Flashing
    
    FirmwareManager --> Storage
    FirmwareManager --> Flashing
```

## 5) Data Model (key entities)

The domain centers on TargetDefinition (hardware targets), PatchConfiguration (firmware patching settings), and RuntimeConfig (device runtime state). These entities drive the flashing workflow.

```mermaid
erDiagram
    TargetDefinition ||--o{ PatchConfiguration : uses
    PatchConfiguration ||--|| FirmwarePatcher : applies
    RuntimeConfig ||--o{ DeviceConfig : represents
    
    TargetDefinition {
        string vendor
        string name
        string platform
        string frequencyType
        string deviceType
    }
    
    PatchConfiguration {
        string bindPhrase
        string wifiSSID
        string wifiPassword
        string regulatoryDomain
        bytes uid
    }
    
    RuntimeConfig {
        string productName
        string version
        string target
        int deviceId
        string domain
    }
```

## 6) API Surface (public endpoints → owning components)

The app exposes 6 main routes: `/` (splash), `/dashboard` (main hub), `/flashing` (firmware flashing), `/settings` (app config), `/device_config` (device runtime), `/firmware_manager` (cache). Device communication uses HTTP at 10.0.0.1.

- `GET /` → SplashScreen → SplashController
- `GET /dashboard` → DashboardScreen → HardwareStatusCard
- `GET /flashing` → FlashingScreen → FlashingController
- `GET /settings` → SettingsScreen → SettingsController
- `GET /device_config` → DeviceSettingsScreen → ConfigViewModel
- `GET /firmware_manager` → FirmwareManagerScreen → FirmwareManagerController

```mermaid
sequenceDiagram
    participant User
    participant Router
    participant Screen
    participant Controller
    participant Service
    
    User->>Router: navigate /flashing
    Router->>Screen: FlashingScreen
    Screen->>Controller: FlashingController
    Controller->>Service: DiscoveryService
    Service-->>Controller: Device IP
    Controller->>Service: DeviceRepository
    Service-->>Screen: FlashingState
    Screen-->>User: Render UI
```

## 7) End-to-End Data Flow (hot path)

The primary user flow is firmware flashing: user selects target → app downloads firmware ZIP → patches binary with bind phrase/WiFi → uploads to device via HTTP → device flashes itself.

```mermaid
sequenceDiagram
    participant User
    participant FlashingController
    participant ReleasesRepository
    participant FirmwareRepository
    participant FirmwarePatcher
    participant DeviceRepository
    
    User->>FlashingController: Select target/version
    FlashingController->>ReleasesRepository: Get version list
    FlashingController->>FirmwareRepository: Download firmware ZIP
    FirmwareRepository-->>FlashingController: Firmware binary
    FlashingController->>FirmwarePatcher: Patch with bind phrase/WiFi
    FirmwarePatcher-->>FlashingController: Patched firmware
    FlashingController->>DeviceRepository: Upload & flash
    DeviceRepository-->>User: Success/Failure
```

## 8) State Model (critical domain entity)

TargetDefinition represents hardware devices and has cascading selection: device type → vendor → frequency → specific target. The selection drives firmware compatibility.

```mermaid
stateDiagram-v2
    [*] --> DeviceType
    DeviceType --> Vendor: Select RX/TX
    Vendor --> Frequency: Select vendor
    Frequency --> Target: Select band
    Target --> Selected: Choose target
    Selected --> [*]
    
    note right of DeviceType
        RX (Receiver)
        TX (Transmitter)
    end note
    
    note right of Frequency
        2.4GHz, 900MHz
        Dual Band
    end note
```

## 9) User Flows (top 1-2 tasks)

The two primary user flows are firmware flashing (core value) and device configuration. Flashing involves target selection → options configuration → version selection → flash execution.

```mermaid
flowchart TD
    Start[User Opens App] --> Splash[Splash Screen]
    Splash --> Dashboard[Dashboard]
    
    Dashboard --> FlashFlow[Flash Firmware]
    FlashFlow --> SelectTarget[Select Target]
    SelectTarget --> Configure[Configure Options]
    Configure --> SelectVersion[Select Version]
    SelectVersion --> Flash[Flash Device]
    Flash --> Success[Success]
    
    Dashboard --> DeviceConfig[Device Settings]
    DeviceConfig --> ViewConfig[View/Edit Config]
    ViewConfig --> Save[Save to Device]
    Save --> Dashboard
```

## 10) Key Components & Responsibilities

- `features/flashing/` — End-to-end firmware flashing (download, patch, flash)
- `features/config/` — Device runtime configuration via heartbeat
- `core/networking/` — Device discovery (mDNS) and WiFi binding
- `core/storage/` — Persistence (SharedPreferences) and firmware caching
- `features/settings/` — Global app settings (binding phrase, WiFi credentials)

## 11) Integrations & External Systems

The app integrates with ExpressLRS Artifactory for firmware binaries, GitHub Releases for version metadata and targets.json, and uses platform channels for native WiFi binding on iOS/Android.

```mermaid
flowchart LR
    subgraph External
        Artifactory[ExpressLRS<br/>Artifactory]
        GitHub[GitHub<br/>Releases]
    end
    
    subgraph App
        FirmwareRepo[FirmwareRepository]
        TargetsRepo[TargetsRepository]
    end
    
    subgraph Native
        iOS[iOS<br/>NetworkExtension]
        Android[Android<br/>VPNService]
    end
    
    FirmwareRepo -->|HTTP| Artifactory
    TargetsRepo -->|HTTP| GitHub
    FirmwareRepo -->|platform channel| iOS
    FirmwareRepo -->|platform channel| Android
```

## 12) Assumptions & Gaps

- TBD: Test coverage details for config/settings features (limited in KB)
- Next reads: `lib/src/features/flashing/data/device_repository.dart` for device HTTP protocol details
- Risks to verify: mDNS discovery reliability on different Android versions, WiFi binding edge cases

