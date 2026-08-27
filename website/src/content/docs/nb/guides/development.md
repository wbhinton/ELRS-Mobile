---
title: "Utviklingsveiledning"
description: Getting started with the ELRS Mobile codebase, project architecture, and developer workflows.
slug: nb/development
sidebar:
  order: 2
---

Velkommen til ELRS Mobile utviklingsguide! Dette prosjektet er en native Flutter-implementering av ExpressLRS-kompilerings- og flashing-pipelinen, designet for å fungere helt offline.

## Forutsetninger
For å bidra til dette prosjektet, vil du trenge følgende verktøy installert:

<div class="flex flex-wrap gap-2 my-6">
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Flutter SDK (Stable)</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Dart SDK</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Python 3.x</span>
  <span class="px-3 py-1 rounded-full bg-white/5 border border-white/10 text-text-muted text-xs font-bold transition-all hover:bg-white/10">Cocoapods (iOS/macOS)</span>
</div>

---

## Komme i gang

1. **Klon depotet**:
   ```bash
   git clone https://github.com/wbhinton/ELRS-Mobile.git
   cd ELRS-Mobile
   ```

2. **Installer avhengigheter**:
   ```bash
   flutter pub get
   ```

3. **Kjør applikasjonen**:
   ```bash
   # For Android
   flutter run
   
   # For iOS (krever en Mac og fysisk enhet/simulator)
   flutter run
   ```

---

## Prosjektarkitektur
Kodebasen følger en funksjon-først-struktur lokalisert i `lib/src/`.

<div class="grid grid-cols-1 md:grid-cols-2 gap-4 lg:gap-6 my-8">
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M216,72H131.31L104,44.69A15.86,15.86,0,0,0,92.69,40H40A16,16,0,0,0,24,56V200a16,16,0,0,0,16,16H216a16,16,0,0,0,16-16V88A16,16,0,0,0,216,72Zm0,128H40V56H92.69l27.31,27.31A15.86,15.86,0,0,0,131.31,88H216Z"></path></svg>
      </div>
      Funksjoner
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">flashing/</span>
        <span class="text-xs text-text-muted/70">Kjernelogikken og brukergrensesnittet for flashing-pipelinen.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">firmware_manager/</span>
        <span class="text-xs text-text-muted/70">Håndterer nedlasting og mellomlagring av fastvare fra artifactory.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">configurator/</span>
        <span class="text-xs text-text-muted/70">Brukergrensesnitt for å angi brukeralternativer som Binding Phrases og WiFi.</span>
      </li>
    </ul>
  </div>
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path></svg>
      </div>
      Kjerne
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">networking/</span>
        <span class="text-xs text-text-muted/70">Plattformspesifikk logikk for prosessbinding til maskinvare-hotspots.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">storage/</span>
        <span class="text-xs text-text-muted/70">Lokal mellomlagring og SQLite-persistens.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">analytics/</span>
        <span class="text-xs text-text-muted/70">Personvernførst-observabilitet (Sentry og Aptabase).</span>
      </li>
    </ul>
  </div>
</div>

---

## Tilstandshåndtering
Vi bruker **Riverpod** for global tilstandshåndtering og **Flutter Hooks** for lokal widget-nivå tilstand. Denne kombinasjonen sikrer et svært reaktivt brukergrensesnitt uten den repeterende koden fra standard `StatefulWidgets`.

---

## Dybdeanalyser

For mer detaljert teknisk informasjon, vennligst se følgende guider:

- [**Technical Architecture**](/guides/technical_architecture): En dypdykk i `FirmwareAssembler` og den native nettverksstakken.
- [**Firmware Validation**](/guides/firmware-validation): Hvordan bruke Dart- og Python-verktøyene for å verifisere binær integritet.

---

## Merknad om JSON-minifisering

Når du reviderer binærfiler, kan du merke små byte-avvik sammenlignet med standard Python Configurator. Dette skyldes **JSON-minifisering**.

Python Configurator injiserer ofte mellomrom etter kolon (f.eks. `{"uid": [1,2,3]}`), mens ELRS Mobile genererer tett JSON (f.eks. `{"uid":[1,2,3]}`). Begge er funksjonelt identiske på maskinvare, da ESP32s interne parser ignorerer dette mellomrommet.

<!-- source_hash: 085cfe5b5087b4c76a42f1e288c0ba6e -->