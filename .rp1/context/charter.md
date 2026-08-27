---
rp1_doc_id: 85d2b001-21b4-48da-aaa1-90689e11ca7c
---
# Project Charter: ELRS Mobile

**Version**: 1.0.0
**Status**: Complete
**Created**: 2026-08-27

## Problem & Context
ExpressLRS firmware is not cross-compatible across major versions (e.g. the 3.x to 4.x transition), so every TX and RX in a fleet must run matching firmware to bind. Traditional flashing tools (the ExpressLRS Web Flasher and configurator) require internet access to fetch hardware targets and firmware. Pilots often discover a firmware mismatch at the flying field, where there is no cell signal or WiFi, and cannot recover — losing the entire flying session. This project exists because that failure happened to its creator: TXs and most RXs were flashed, one RX was missed, and the day was lost. It matters now because ExpressLRS adoption is large and growing globally, version transitions keep happening, and no offline-capable mobile flashing tool existed.

## Target Users
RC hobbyist pilots (drones/FPV, planes, cars) who run ExpressLRS radio links and need to flash and configure their own TX modules and RX units. They are frequently in the field without reliable internet and manage multiple devices that must stay on matching firmware. The user base is global and multilingual (the app has been localized into several languages), spans both Android and iOS, and ranges from casual flyers to enthusiasts maintaining larger fleets.

## Business Rationale
ELRS Mobile lets pilots download ExpressLRS hardware targets and firmware zips from the ExpressLRS Artifactory repo ahead of time, cache them locally on the phone, and build and flash firmware on demand with no internet connection required. Flashing logic is ported directly from the official ExpressLRS Web Flasher (JavaScript to Dart) for fidelity with the canonical tool. It is differentiated as the only mobile-first, fully offline ExpressLRS flashing and device-management solution, delivered as a free Flutter app on Google Play and the Apple App Store. Traction: first public release March 2026, coverage by a small YouTube channel in April 2026 and a major channel in July 2026, and over 20,000 downloads across platforms with worldwide reach.

## Scope Guardrails

### Will
- Flash ExpressLRS firmware to receivers and transmitters over  WiFi-OTA only 
- Download and locally cache ExpressLRS hardware targets and firmware zips from the ExpressLRS Artifactory repo for fully offline use
- Build firmware on demand from cached targets and firmware
- Manage ExpressLRS device parameters and configuration
- Support Android and iOS with platform parity, and multiple localized languages

### Won't
- Support non-ExpressLRS radio systems
- Configure flight controllers
- Manage radio/EdgeTX/OpenTX models or handset configuration
- Provide cloud accounts or cross-device sync

## Success Criteria
The project succeeds on reach and reliability. Primary metrics: continued download growth from a baseline of roughly 20,000 across platforms; app store rating of 4.5 or higher; crash-free session rate of 99.5% or higher; and successful offline firmware flash completions. Secondary metrics: language/localization coverage and iOS/Android platform parity. Failure modes: rising crash rate, declining store rating, stalled or declining downloads, and users reporting failed flashes. Definition of done for the core product is met: pilots can flash and configure ExpressLRS RXs and TXs from a phone with no internet connection.
