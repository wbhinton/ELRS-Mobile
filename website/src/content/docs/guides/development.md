---
title: Development Guide
description: Getting started with the ELRS Mobile codebase, project architecture, and developer workflows.
slug: development
---

Welcome to the ELRS Mobile development guide! This project is a native Flutter implementation of the ExpressLRS compilation and flashing pipeline, designed to work entirely offline.

## Prerequisites

To contribute to this project, you will need the following tools installed:

- **Flutter SDK**: Use the latest `stable` channel.
- **Dart SDK**: Automatically included with Flutter.
- **Python 3.x**: Required for running certain firmware audit scripts.
- **Cocoapods**: Required only if you are building for iOS/macOS.
- **IDE**: We recommend [VS Code](https://code.visualstudio.com/) with the Flutter extension, or [Android Studio](https://developer.android.com/studio).

## Getting Started

1. **Clone the repository**:
   ```bash
   git clone https://github.com/wbhinton/ELRS-Mobile.git
   cd ELRS-Mobile
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the application**:
   ```bash
   # For Android
   flutter run
   
   # For iOS (requires a Mac and physical device/simulator)
   flutter run
   ```

---

## Project Architecture

The codebase follows a feature-first structure located in `lib/src/`.

### 1. Features (`lib/src/features/`)
Each directory represents a discrete functional module of the app:
- **`flashing/`**: The core logic and UI for the flashing pipeline.
- **`firmware_manager/`**: Handles downloading and caching firmware from the artifactory.
- **`configurator/`**: UI for setting user options like Binding Phrases and WiFi.
- **`settings/`**: App-wide configuration and credential management.

### 2. Core (`lib/src/core/`)
Shared services and infrastructure used across multiple features:
- **`networking/`**: Platform-specific logic for process-binding to hardware hotspots.
- **`storage/`**: Local cache management and SQLite/SharedPreference persistence.
- **`analytics/`**: Privacy-first observability (Sentry and Aptabase).

### 3. State Management
We utilize **Riverpod** for global state management and **Flutter Hooks** for local widget-level state. This combination ensures a highly reactive UI without the boilerplate of standard `StatefulWidgets`.

---

## Deep Dives

For more detailed technical information, please refer to the following guides:

- [**Technical Architecture**](/guides/technical_architecture): A deep dive into the `FirmwareAssembler` and the native networking stack.
- [**Firmware Validation**](/guides/firmware-validation): How to use the Dart and Python tools to verify binary integrity.

---

## Note on JSON Minification

When auditing binaries, you may notice slight byte-offsets compared to the standard Python Configurator. This is due to **JSON minification**. 

The Python Configurator often injects spaces after colons (e.g., `{"uid": [1,2,3]}`), while ELRS Mobile generates dense JSON (e.g., `{"uid":[1,2,3]}`). Both are functionally identical on hardware, as the ESP32's internal parser ignores this whitespace.
