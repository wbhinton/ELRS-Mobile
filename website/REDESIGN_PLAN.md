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
- [ ] Components: `Section`, `Card`, `StoreBadge` (official badges), `VideoEmbed`
      (thumbnail facade → `youtube-nocookie` iframe on click), `Steps`, `FeatureTour`.
- [ ] New section order: hero (with screenshot) → how it works (cache at home →
      connect to device Wi-Fi → flash) → feature tour (flashing, device config,
      firmware manager, profiles) → compatibility summary → videos → install → footer.
- [ ] Screenshots via `astro:assets` (responsive WebP).
- [ ] Replace generic highlight copy and "Production" badges; move hard-coded
      English strings into `ui.json`.

### Phase 4 — Hardware from data
- [ ] `src/data/verified.json` (seeded with RadioMaster targets).
- [ ] `src/data/hardware.ts`: Wi-Fi-flashable targets from `targets.json`,
      grouped by brand, with verified flag, chip list, counts.
- [ ] `HardwareSummary` on landing (counts, chips, "not supported" line).
- [ ] `supported_hardware` → `.mdx` rendering `HardwareList` (all locales).

### Phase 5 — Docs information architecture
- [ ] Sidebar groups by slug (no file moves): "Using ELRS Mobile" (user_guide,
      supported_hardware) and "Developers" (development, technical_spec,
      technical_architecture, firmware-validation).
- [ ] Delete translated developer docs; Starlight falls back to English.
- [ ] Translation script: read `locales.json`, skip developer docs, handle `.mdx`.

### Phase 6 — Cleanup and guardrails
- [ ] Remove dead CSS (`.hero-gradient`, `.astro-4yphtoen` hack), unused assets,
      starter README.
- [ ] Real `website/README.md`: where each fact lives; how to add a locale,
      video, feature, or verified target.
- [ ] Website build job in `ci.yml` (path-filtered to `website/**`) plus link check.

### Phase 7 — Translation and verification
- [ ] Manually dispatch translation workflow for new strings.
- [ ] Verify against baseline: routes preserved, page weight, `hreflang` and
      `og:` tags present, one analytics event per click, 375px with no horizontal
      scroll, language switcher on every page.
