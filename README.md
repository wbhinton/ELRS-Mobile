# ELRS Mobile

## Overview
ELRS Mobile is a cross-platform mobile application designed for the advanced management and configuration of ExpressLRS (ELRS) 4.0 hardware. The application provides a native interface for adjusting device parameters, mapping PWM outputs, and executing firmware updates over a local wireless network.

## Feature List
- **Automated Discovery**: Real-time device detection via mDNS and static IP polling.
- **Dynamic Configuration**: Comprehensive access to ELRS 4.x runtime options and hardware settings.
- **PWM Mapping**: Granular control over physical pin assignments and output frequencies (50Hz–400Hz/DSHOT).
- **Firmware Flashing**: Integrated firmware downloader and patcher for direct device updates.
- **Connection Resilience**: Robust heartbeat logic to maintain operational continuity during transient network fluctuations.
- **Manual IP Override**: Support for static connectivity in non-standard or restricted network environments.

## Quick Start

### Prerequisites
- Flutter SDK (Latest Stable)
- ELRS 4.0 compatible hardware with WiFi enabled

### Key Dependencies
- `flutter_riverpod`: Reactive state management.
- `dio`: High-performance HTTP client for API interactions.
- `shared_preferences` & `flutter_secure_storage`: Persistent local data management.
- `freezed`: Type-safe data modeling and immutability.

### Development
1. Clone the repository.
2. Execute `flutter pub get` to install dependencies.
3. Run `dart run build_runner build` to generate data models and providers.
4. Execute `flutter run` on a connected mobile device or emulator.

## Documentation
Additional technical details and operational procedures are available in the `/docs` directory:
- [User Guide](docs/USER_GUIDE.md): Operational workflows and connectivity procedures.
- [Technical Specification](docs/TECHNICAL_SPEC.md): System architecture, API definitions, and data mappings.

## Compliance & Disclaimer
This application is an independent, community-driven project. It is **not** an official release from the ExpressLRS development team. The software is provided "as is," and users assume all risks associated with hardware configuration and firmware updates.
