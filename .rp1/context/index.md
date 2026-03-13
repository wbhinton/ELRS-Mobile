# ELRS - Knowledge Base

**Type**: Single Project
**Languages**: Dart, Flutter
**Version**: v3.x
**Updated**: 2026-03-12

## Project Summary

ELRS (ExpressLRS) Mobile App is a Flutter application for flashing ExpressLRS firmware to RC model receivers and transmitters. It provides target selection, firmware download, binary patching with user configuration (binding phrase, WiFi credentials), and device flashing over WiFi.

## Quick Reference

| Aspect | Value |
|--------|-------|
| Entry Point | `lib/main.dart` |
| Key Pattern | Clean Architecture + Riverpod State Management |
| Tech Stack | Flutter, Riverpod, go_router, Freezed, dio |

## KB File Manifest

**Progressive Loading**: Load files on-demand based on your task.

| File | Lines | Load For |
|------|-------|----------|
| architecture.md | ~211 | System design, component relationships, data flows |
| modules.md | ~213 | Component breakdown, module responsibilities |
| patterns.md | ~96 | Code conventions, implementation patterns |
| concept_map.md | ~127 | Domain terminology, business concepts |

## Task-Based Loading

| Task | Files to Load |
|------|---------------|
| Code review | `patterns.md` |
| Bug investigation | `architecture.md`, `modules.md` |
| Feature implementation | `modules.md`, `patterns.md` |
| Strategic analysis | ALL files |

## How to Load

```
Read: {{$RP1_ROOT}}/context/{filename}
```

## Project Structure

```
lib/src/
├── main.dart                    # App entry point
├── app.dart                     # Root widget with ProviderScope
├── router.dart                  # GoRouter configuration (+ /legal route)
├── bit_list.dart                # Bit-level data structure
├── elrs_mappings.dart           # ELRS constant mappings
├── core/
│   ├── theme/app_theme.dart     # Material 3 theming
│   ├── presentation/            # Responsive layout utilities
│   ├── storage/                 # Persistence & caching
│   └── networking/              # Device discovery & HTTP
└── features/
    ├── flashing/                # Firmware flashing (main feature)
    ├── dashboard/               # Main screen
    ├── settings/                # App configuration (+ LegalNoticeScreen)
    ├── config/                  # Device runtime config
    ├── configurator/            # Device settings UI
    ├── firmware_manager/         # Offline cache management
    ├── updates/                 # App updates
    └── splash/                  # Launch screen
```

## Navigation

- **[architecture.md](architecture.md)**: System design and diagrams
- **[modules.md](modules.md)**: Component breakdown
- **[patterns.md](patterns.md)**: Code conventions
- **[concept_map.md](concept_map.md)**: Domain terminology
