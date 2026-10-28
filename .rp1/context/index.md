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
**Languages**: Dart (Flutter, primary); TypeScript/Astro (website); Python (build and validation scripts)
**Version**: 1.0.45+111
**Updated**: 2026-10-27 (commit 3e8eab5)

## Project Summary

ELRS Mobile is an offline-first Flutter app (Android primary, iOS, macOS) that lets RC/FPV pilots flash ExpressLRS firmware to receivers and transmitters over Wi-Fi, with no laptop and no internet at the field. It caches firmware and hardware definitions from the ExpressLRS Artifactory (3.3.0+ only, unified firmware), assembles the binary on-device (logic ported from the official Web Flasher), and uploads it over the device's hotspot with mDNS discovery and Android process binding. Flashing is guarded (chip-family hard block, forceable target mismatch, missing-binding-phrase prompt) and honest: success is reported only when the device replies `ok`, and a silent drop after upload is an amber "unconfirmed" result. Force Flash re-uploads with `?force=1`, confirming via `/forceupdate` only if still mismatched. Device settings are edited in the device's own web UI. Direct-download APK builds (`DISTRIBUTION=direct`) check `cdn.elrsmobile.com/latest.json` for updates; store builds don't. All UI text is localized (18 languages) and enforced by tests. Usage analytics (Aptabase) are on by default with an opt-out; Sentry crash reporting runs in release builds regardless, as the website privacy policy now states. The companion website (`website/`, Astro + Starlight, deployed by Cloudflare) was rebuilt around single sources of truth, a data-driven landing page, and a hardware list generated from the app's `assets/targets.json` plus analytics-verified badges.

## Quick Reference

| Aspect | Value |
|--------|-------|
| Entry Point | `lib/main.dart` -> `lib/src/app.dart` (`MaterialApp.router`, 8 routes in `lib/src/router.dart`) |
| Key Pattern | Feature-first layered slices + Riverpod codegen DI; sealed typed errors; confirm-by-reply flash semantics |
| Tech Stack | Flutter 3.11+, Riverpod (codegen), flutter_hooks, go_router, Freezed + json_serializable, Dio, nsd, flutter_secure_storage 11, Sentry, Aptabase; website: Astro 5 + Starlight + Tailwind 3 |
| Build flags | `--dart-define=SENTRY_DSN=...`, `--dart-define=DISTRIBUTION=direct` (direct APK only) |
| Tests / CI | `flutter analyze`, `flutter test` (8 files incl. l10n hygiene); `ci.yml`, `website.yml` (build + link check), `release.yml` |

## KB File Manifest

**Progressive Loading**: Load files on-demand based on your task.

| File | Lines | Load For |
|------|-------|----------|
| architecture.md | ~144 | System design, layers, data flows, integrations, security/privacy, deployment |
| interaction-model.md | ~109 | Surfaces, user-visible states, feedback loops, cross-surface deltas |
| modules.md | ~140 | Module responsibilities, key components, dependencies, metrics |
| patterns.md | ~98 | Conventions, error handling, telemetry, testing, I/O, website conventions |
| concept_map.md | ~128 | Domain terms (targets, unified firmware, guards, FlashError, verified hardware) |

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
├── main.dart                  # Logger -> Sentry breadcrumbs, ProviderContainer, Sentry init (if DSN)
├── l10n/                      # ARB sources, 18 locales (app_en.arb is the source)
└── src/
    ├── app.dart, router.dart  # composition root + go_router (8 routes)
    ├── core/                  # networking, storage, analytics, app_info, theme, presentation, utils
    └── features/
        ├── flashing/          # CORE: targets, cache/download, assembly, guards, upload, typed errors
        ├── config/            # device config read (+ pre-3.1 fallback), frequency validation
        ├── configurator/      # device web UI in a locked WebView (only settings editor)
        ├── firmware_manager/  # offline firmware cache UI
        ├── settings/          # profiles, defaults, storage, language, analytics, Expert Mode
        ├── app_update/        # update check, direct-download builds only
        └── dashboard/ splash/ support/
test/                          # 8 test files
website/                       # Astro + Starlight site and docs (see website/README.md, REDESIGN_PLAN.md)
firmware_testing/              # Dart logic validator + Python ground-truth auditor
assets/targets.json            # ExpressLRS targets (synced upstream; also feeds the website)
```

## Navigation

- **[architecture.md](architecture.md)**: System design, layers, data flows, integrations, privacy, deployment
- **[interaction-model.md](interaction-model.md)**: Surfaces, states, feedback loops, cross-surface deltas
- **[modules.md](modules.md)**: Module breakdown, components, dependencies, metrics, quality
- **[patterns.md](patterns.md)**: Naming, types, errors, telemetry, testing, I/O, DI, website conventions
- **[concept_map.md](concept_map.md)**: Domain concepts, rules, bounded contexts, glossary
