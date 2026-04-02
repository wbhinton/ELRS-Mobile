# ExpressLRS Configurator - Knowledge Base

**Type**: Single Project
**Languages**: Dart, Swift, Kotlin, Python
**Version**: v3.x/v4.x
**Updated**: 2026-04-02

## Project Summary

ExpressLRS Configurator is a Flutter mobile application for flashing ExpressLRS firmware to RC model receivers and transmitters. It provides offline firmware caching, local binary patching with user configuration (binding phrase, WiFi credentials), and device flashing over WiFi via HTTP upload. Features platform-specific WiFi binding (Android) to prevent cellular fallback on mobile devices.

## Quick Reference

| Aspect | Value |
|--------|-------|
| Entry Point | `lib/main.dart` |
| Key Pattern | HookConsumerWidget + Riverpod + Freezed |
| Tech Stack | Flutter, Riverpod, go_router, Freezed, Dio, Aptabase, Sentry |
| Website | Astro Starlight + Tailwind CSS |

## KB File Manifest

**Progressive Loading**: Load files on-demand based on your task.

| File | Lines | Load For |
|------|-------|----------|
| architecture.md | ~195 | System design, component relationships, data flows |
| modules.md | ~145 | Component breakdown, module responsibilities |
| patterns.md | ~148 | Code conventions, implementation patterns |
| concept_map.md | ~125 | Domain terminology, business concepts |

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
├── bit_list.dart               # Bit-level access to integer values
├── core/
│   ├── analytics/              # Aptabase analytics service
│   ├── theme/                  # Material 3 theming
│   ├── presentation/           # Responsive layout utilities
│   ├── storage/                # Persistence & caching
│   ├── networking/             # Device discovery & HTTP
│   └── utils/                  # Validation utilities
└── features/
    ├── flashing/               # Firmware flashing (main feature)
    │   ├── presentation/       # UI & controllers
    │   ├── data/               # Repositories
    │   ├── domain/             # Domain models
    │   ├── application/        # Firmware patching
    │   ├── utils/              # Assemblers, resolvers
    │   └── state/              # State providers
    ├── dashboard/              # Main screen
    ├── settings/               # App configuration
    ├── config/                 # Device runtime config
    ├── configurator/           # Device settings UI
    ├── firmware_manager/       # Offline cache management
    ├── support/                # Help & troubleshooting
    └── splash/                 # App launch screen

website/
├── src/
│   ├── pages/                  # Landing page
│   ├── layouts/                # Base layout with nav
│   └── content/docs/guides/    # Starlight documentation
└── astro.config.mjs            # Astro + Starlight + Tailwind config
```

## Navigation

- **[architecture.md](architecture.md)**: System design and diagrams
- **[modules.md](modules.md)**: Component breakdown
- **[patterns.md](patterns.md)**: Code conventions
- **[concept_map.md](concept_map.md)**: Domain terminology
