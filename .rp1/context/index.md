# ELRS - Knowledge Base

**Type**: Single Project
**Languages**: Dart, Flutter
**Version**: v3.x
**Updated**: 2026-03-15

## Project Summary

ELRS (ExpressLRS) Mobile App is a Flutter application for flashing ExpressLRS firmware to RC model receivers and transmitters. It provides target selection, firmware download, binary patching with user configuration (binding phrase, WiFi credentials), and device flashing over WiFi. Now includes Aptabase analytics for usage tracking.

## Quick Reference

| Aspect | Value |
|--------|-------|
| Entry Point | `lib/main.dart` |
| Key Pattern | Clean Architecture + Riverpod + Analytics |
| Tech Stack | Flutter, Riverpod, go_router, Freezed, dio, Aptabase |

## KB File Manifest

**Progressive Loading**: Load files on-demand based on your task.

| File | Lines | Load For |
|------|-------|----------|
| architecture.md | ~208 | System design, component relationships, data flows |
| modules.md | ~171 | Component breakdown, module responsibilities |
| patterns.md | ~159 | Code conventions, implementation patterns |
| concept_map.md | ~98 | Domain terminology, business concepts |

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
├── main.dart                    # App entry point, analytics init
├── app.dart                     # Root widget with ProviderScope
├── router.dart                  # GoRouter configuration
├── core/
│   ├── analytics/               # Aptabase analytics service
│   ├── theme/                   # Material 3 theming
│   ├── presentation/            # Responsive layout utilities
│   ├── storage/                 # Persistence & caching
│   └── networking/              # Device discovery & HTTP
└── features/
    ├── flashing/               # Firmware flashing (main feature)
    ├── dashboard/               # Main screen
    ├── settings/                # App configuration (+ analytics)
    ├── config/                  # Device runtime config
    ├── configurator/            # Device settings UI
    ├── firmware_manager/        # Offline cache management
    ├── updates/                 # App updates (legacy)
    └── splash/                  # Launch screen
```

## Navigation

- **[architecture.md](architecture.md)**: System design and diagrams
- **[modules.md](modules.md)**: Component breakdown
- **[patterns.md](patterns.md)**: Code conventions
- **[concept_map.md](concept_map.md)**: Domain terminology
