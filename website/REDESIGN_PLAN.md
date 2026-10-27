# Website Redesign Plan

Status tracker and design rationale for the elrsmobile.com overhaul. Update the
checkboxes as phases land so work can resume from any session.

## Goals

- Clearly convey what the app is, whether it supports the visitor's hardware,
  what using it looks like, and why it can be trusted.
- Efficient: smaller pages, no render-blocking third-party scripts, no eager
  video embeds.
- Easy to use: working mobile nav, language switcher everywhere, one visual
  shell across landing page and docs.
- Easy to maintain: every fact lives in exactly one place (DRY).

## Architecture

Four layers; each consumes only the one above it.

```
1. Data        src/config/locales.json · src/config/site.ts · ../targets.json
               src/data/verified.json · src/i18n/ui.json
      ↓
2. Shell       Starlight renders every page (landing, privacy, docs)
      ↓
3. Components  Section · Card · StoreBadge · VideoEmbed · Steps · FeatureTour
               HardwareSummary · HardwareList
      ↓
4. Pages       thin compositions of components fed by data
```

| Fact | Single source | Consumers |
|---|---|---|
| Locale list | `src/config/locales.json` | `astro.config.mjs`, `[lang]` pages, `scripts/translate_astro.cjs` |
| Store / beta / APK / social URLs, analytics ID, videos, features, steps | `src/config/site.ts` | components, head config |
| UI copy | `src/i18n/ui.json` via `useTranslations(lang)` | all components |
| Brand colors | `tailwind.config.mjs` | Tailwind + Starlight (via `@astrojs/starlight-tailwind`) |
| Supported hardware | `../targets.json` (kept current by `update_targets.yml`) | `src/data/hardware.ts` → landing summary + docs list |
| Hardware-verified targets | `src/data/verified.json` | `src/data/hardware.ts` (badge) |
| Header, footer, `<head>` | Starlight + component overrides | every page |
| Analytics events | `data-track` attributes + one delegated listener | any link |

## Constraints

- Preserve URLs: `/privacy` (linked from store listings), `/user_guide`,
  `/supported_hardware`, `/development`, `/technical_spec`,
  `/technical_architecture`, `/firmware-validation`, every `/<lang>/` prefix,
  and the `/#installation` anchor. Diff the built route list against the
  Phase 0 baseline.
- No automatic Gemini spend. New strings are added in English only; other
  locales fall back to English until the translation workflow is dispatched
  manually.
- No new runtime dependencies. YouTube facade and analytics delegation are
  hand-written.
- Deployment: Cloudflare builds from GitHub automatically; CI only needs a
  build check, not a deploy step.

## Decisions (2026-10-27)

1. Ko-fi floating widget removed; footer link kept.
2. Dark theme only (matches the app; one token set to maintain).
3. Developer docs (development, technical_spec, technical_architecture,
   firmware-validation) are English-only; translated copies deleted.
4. Hardware list generated from `targets.json` (Wi-Fi-flashable targets),
   labelled "supported". `verified.json` badges hardware-verified targets;
   seeded with all RadioMaster targets, full list to be supplied later.
5. Hosting is Cloudflare (GitHub-linked worker builds on push).

## Phases

Each phase is one commit that builds and could ship on its own.

### Phase 0 — Baseline
- [x] Build current site; save route list and page weights for later diffing.
      Baseline: 239 HTML routes; `/` 22.1 KB, `/privacy` 10.4 KB, `/user_guide` 55.5 KB.

### Phase 1 — Single sources of truth (no visual change)
- [x] `src/config/locales.json`; wire into `astro.config.mjs`, `[lang]/index.astro`,
      `[lang]/privacy.astro`, `scripts/translate_astro.cjs`. Registers `nb`
      (also removed 96 bogus `/<lang>/nb/*` routes the unregistered locale produced).
- [x] `src/i18n/index.ts` with `useTranslations(lang)` and `localizePath(lang, path)`;
      replace the three copies of `t()`.
- [x] `src/config/site.ts`; move all hard-coded URLs/IDs into it. (Privacy
      page's "our GitHub Repository" link now points at the app repo, not ExpressLRS.)
- Moved to Phase 2: `@astrojs/starlight-tailwind` token unification (it changes
  Tailwind preflight, so it is a visual change that belongs with the shell move).

### Phase 2 — One shell
- [x] `@astrojs/starlight-tailwind`; brand colors defined once in `tailwind.config.mjs`;
      drop duplicated Starlight vars from `custom.css`.
- [x] Prototype landing on `StarlightPage` (splash template, `not-content` wrapper).
      Fallback if it fights the design: Starlight Header/Footer overrides shared
      with a slim custom landing layout.
- [x] Landing and privacy on the shared shell; delete `src/layouts/Layout.astro`.
- [x] Footer override: privacy link, copyright, trademark, support links.
- [x] Head config: analytics once; `og:image` / Twitter card (1200×630 asset).
- [x] Delegated `data-track` click tracking; remove all inline `onclick`
      (fixes double-counted `app_download_click`).
- [x] Remove Ko-fi floating widget and its render-blocking script.
- [x] Force dark theme; hide theme toggle.
- Notes: homepage HTML grew 22 KB → 32 KB (shared Starlight header/search markup;
  CSS is shared and cached). `og-image.png` is generated from the iPhone store
  screenshot. Dev server must be restarted after `tailwind.config.mjs` changes.
- Carry-overs: `supported_hardware` "Unsupported" card is offset by Starlight's
  markdown sibling margin (fixed by Phase 4 rewrite). `public/images/hero-iphone-radio.png`
  depicts a fictional app ("DRONE SYNC") — do not use; delete in Phase 6.

### Phase 3 — Components and data-driven landing page
- [x] Components: `Section`, `Card`, `StoreBadge` (official badges), `VideoEmbed`
      (thumbnail facade → `youtube-nocookie` iframe on click), `Steps`, `FeatureTour`.
- [x] New section order: hero (with screenshot) → how it works (cache at home →
      connect to device Wi-Fi → flash) → feature tour (flashing, device config,
      firmware manager, profiles) → compatibility summary → videos → install → footer.
- [x] Screenshots via `astro:assets` (responsive WebP).
- [x] Replace generic highlight copy and "Production" badges; move hard-coded
      English strings into `ui.json`.
- Notes: content model in `src/data/landing.ts`; components in
  `src/components/landing/`. Phone screenshots come from
  `scripts/crop_store_screenshots.py` (re-run after store screenshots change);
  the discovery screenshot (05) is skipped because its dimmed dialog defeats
  detection. YouTube thumbnails are fetched and optimised at build time; no
  YouTube request until play. 15 dead `ui.json` keys pruned from all locales,
  and `translate_astro.cjs` now prunes removed keys itself. Phone header shows
  the Docs link as an icon so long CTA labels fit at 360px.
- Translation: a test run accidentally translated the 25 new strings for `de`
  and `es` (2 Gemini calls). The other 15 locales still fall back to English
  until Phase 7.

### Phase 4 — Hardware from data
- [x] `src/data/verified.json`, generated by `scripts/build_verified.py` from the
      analytics export (`verified_hardware.csv`, uncommitted): a target is verified
      after ≥1 successful flash. 232 targets; 15,640 total flashes as of 2026-10-27.
- [x] `src/data/hardware.ts`: Wi-Fi-flashable ESP targets from `assets/targets.json`
      (the copy the app bundles; the repo-root `targets.json` is a stale Feb 2026
      copy), grouped by brand, with verified flag, chip list, counts.
      Result: 314 devices, 55 brands, 230 verified.
- [x] `HardwareSummary` on landing (stats, chipsets, "not supported" line, link).
- [x] `supported_hardware` → `.mdx` in all locales rendering `HardwareList`
      (search filter, Verified badges); imports use the `~/` tsconfig alias so the
      translated copies resolve. Translation hash marker is an MDX comment in `.mdx`.
- Notes: `RadioMaster TX12 Internal` / `TX16S Internal` in the export predate the
  upstream MK2 renames, so they match no current target (dev logs a warning).
  Locale pages keep their old "Tested Hardware" heading until Phase 7 re-translates
  the changed English source.

### Phase 5 — Docs information architecture
- [x] Sidebar groups by slug (no file moves): "Using ELRS Mobile" (user_guide,
      supported_hardware) and "Developers" (development, technical_spec,
      technical_architecture, firmware-validation).
- [x] Delete translated developer docs; Starlight falls back to English.
- [x] Translation script: read `locales.json`, skip developer docs, handle `.mdx`.
- Notes: grouping lives in `src/config/docs.json` (one place for sidebar order and
  whether a doc is translated); group labels come from `ui.json`. Routes unchanged
  (145): Starlight serves English fallbacks with a "not available in your language"
  notice at `/<lang>/development` etc.
- Optional follow-up: the User Guide's own `## Overview` heading duplicates
  Starlight's automatic "Overview" TOC entry. Renaming it changes the English
  source hash, so do it before the Phase 7 translation run if at all.

### Phase 6 — Cleanup and guardrails
- [x] Removed pre-Phase-2 Starlight workaround CSS (logo size, mobile TOC, header
      height, code padding; before/after screenshots showed only Expressive Code's
      default padding change), the fictional `hero-iphone-radio.png`, unused
      `logo.svg`, the Astro starter `favicon.svg`, and the stale repo-root
      `targets.json` (nothing referenced it). `favicon.ico` kept (browsers request it).
- [x] Real `website/README.md`: where each fact lives and common tasks.
- [x] `.github/workflows/website.yml` (separate from `ci.yml` so it can be
      path-filtered): `npm ci`, build, `npm run check:links`
      (`scripts/check_links.mjs`, no dependencies).
- [x] Link check found live broken `/guides/...` links in the User Guide (all
      locales) and Development Guide; fixed, and the translated User Guides' hash
      markers carried forward so Phase 7 doesn't re-translate them for this.
- [x] Added (user request): install count under the hero CTAs with the flash
      total. `src/data/usage.json` (38,422 installs as of 2026-10-27, edit by hand);
      public figures rounded down via `formatAtLeast` ("38,000+"). Hero is now a
      Starlight override (`src/components/starlight/Hero.astro`) so stats and beta
      links sit under the CTAs; the `.hero` CSS overrides were removed.

### Docs refresh for v1.0.45 (added 2026-10-27, before Phase 7)
- [x] User Guide rewritten against the current app: install options incl. direct
      APK + update check, 3.3.0+ firmware floor, auto target selection, flash
      phases, safety checks (chip block, target mismatch/Force Flash, no binding
      phrase, unconfirmed flash), profiles, Device Config, Settings map, Expert Mode,
      troubleshooting. Starlight asides replace hand-written HTML blocks; the
      duplicate "Overview" TOC entry is gone.
- [x] Developer docs (English-only) rewritten and verified against code: setup,
      codegen, `--dart-define` options (`SENTRY_DSN`, `DISTRIBUTION=direct`),
      project structure, tests/CI, releases; real device endpoints; current
      force-flash (`?force=1`, then `/forceupdate`) and success/unconfirmed
      semantics; persistence split; firmware validation workflow.
- Note: the rp1 knowledge base (2026-09-22) is stale on force flash, flash-result
  handling and `app_update`; the docs follow the code.
- OPEN (owner decision): Aptabase `shareAnalytics` defaults to `true` and Sentry is
  not gated by the toggle, but the privacy policy says analytics are off by
  default. Docs avoid stating a default until this is resolved.

### Phase 7 — Translation and verification
- [ ] Manually dispatch translation workflow for new strings.
- [ ] Verify against baseline: routes preserved, page weight, `hreflang` and
      `og:` tags present, one analytics event per click, 375px with no horizontal
      scroll, language switcher on every page.
