---
scope: kbRoot
path_pattern: "index.md"
producer: knowledge-base
type: document
description: "Project overview and progressive KB entry point. Always generated -- serves as the navigation hub for all other KB documents."
strictness: strict
---
# ELRS Mobile - Knowledge Base

**Type**: Single Project
**Languages**: Dart (Flutter, primary); TypeScript/Astro (docs website); Python (build scripts)
**Version**: 1.0.44-rc1+46
**Updated**: 2026-09-22

## Project Summary

ELRS Mobile is a mobile-first, fully offline Flutter app (Android/iOS, with a maintained macOS desktop target) that lets RC/FPV pilots flash ExpressLRS firmware to receivers and transmitters, and configure them, with no internet connection. It caches hardware targets and firmware zips from the ExpressLRS Artifactory repo ahead of time, assembles the correct firmware payload on-device (flashing logic ported from the official Web Flasher, JS to Dart), and flashes over the device's Wi-Fi hotspot with mDNS discovery and native forced routing. It exists because ExpressLRS major-version firmware mismatches (e.g. 3.x/4.x) strand pilots at the flying field where no other tool works offline. As of this update, flashable/downloadable firmware is gated to `>= 3.3.0` (unified firmware only), while device config reading still falls back to legacy endpoints for older firmware; the UI now also supports Norwegian Bokmål (`nb`). A full-codebase dead-code audit + cleanup pass removed ~1,150 lines (an abandoned self-update module, a dead native device-config editor, an unwired vendored package, and assorted dead methods), and the flash-upload progress bar/status machine was reworked for accuracy — it now distinguishes locating/unpacking cached firmware (the normal offline path) from a rare network-fallback download, and shows an indeterminate "finalizing" state during the post-upload device write/reboot window that has no progress signal of its own.

## Quick Reference

| Aspect | Value |
|--------|-------|
| Entry Point | `lib/main.dart` -> `lib/src/app.dart` (`MaterialApp.router`) |
| Key Pattern | Feature-first layered slices + Riverpod codegen DI / reactive state |
| Tech Stack | Flutter 3.11+, Riverpod (annotation codegen), go_router, Freezed + json_serializable, Dio, nsd (mDNS), flutter_secure_storage, Sentry, Aptabase |

## KB File Manifest

**Progressive Loading**: Load files on-demand based on your task.

| File | Lines | Load For |
|------|-------|----------|
| architecture.md | ~137 | System design, layers, data flows, integrations, deployment |
| interaction-model.md | ~122 | Cross-surface interaction semantics, UX principles, user-visible states |
| modules.md | ~186 | Component breakdown, module responsibilities, dependency graph, metrics |
| patterns.md | ~99 | Code conventions, error handling, DI, concurrency, I/O idioms |
| concept_map.md | ~159 | Domain terminology (ELRS, UID, targets, unified firmware), bounded contexts |

## Task-Based Loading

| Task | Files to Load |
|------|---------------|
| Code review | `patterns.md` |
| Bug investigation | `architecture.md`, `modules.md` |
| Feature implementation | `modules.md`, `patterns.md` |
| Frontend / UX / surface work | `interaction-model.md`, `modules.md`, `patterns.md` |
| Strategic analysis | ALL files |

## How to Load

```
Read: .rp1/context/{filename}
```

## Project Structure

```
lib/
├── main.dart                 # entrypoint: Logger + Sentry breadcrumbs, ProviderContainer
├── l10n/                      # ARB translation sources (18 locales, incl. Norwegian Bokmål "nb")
└── src/
    ├── app.dart, router.dart  # composition root + go_router (8 routes)
    ├── core/
    │   ├── networking/        # mDNS discovery, connectivity, sequential device Dio, native Wi-Fi binding, expected_reboot_drop.dart
    │   ├── storage/           # SharedPreferences + secure storage, firmware/hardware cache
    │   ├── analytics/ theme/ presentation/ utils/
    └── features/
        ├── flashing/          # CORE: download -> patch/assemble -> flash (data/domain/application/utils/state/presentation)
        ├── config/            # live device RuntimeConfig read, frequency validation (writes now only via embedded WebView)
        ├── firmware_manager/  # offline firmware cache management UI
        ├── settings/          # profiles, locale, Expert Mode, analytics opt-in
        ├── dashboard/ configurator/ splash/ support/
website/                       # Astro/Starlight marketing + docs site (separate)
firmware_testing/              # Python + Dart byte-match audit tools vs the Web Flasher
```

## Navigation

- **[architecture.md](architecture.md)**: System design, layer model, data flows, integrations, deployment
- **[interaction-model.md](interaction-model.md)**: Surfaces, user-visible states, feedback loops, cross-surface deltas
- **[modules.md](modules.md)**: Feature/core module breakdown, key components, dependency graph, metrics, quality insights
- **[patterns.md](patterns.md)**: Naming, type modeling, error handling, observability, concurrency, DI, codegen
- **[concept_map.md](concept_map.md)**: Domain concepts, relationships, bounded contexts, terminology glossary
