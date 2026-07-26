---
title: "Utvecklingsguide"
description: Getting started with the ELRS Mobile codebase, project architecture, and developer workflows.
slug: sv/development
sidebar:
  order: 2
---

Välkommen till ELRS Mobile utvecklingsguide! Detta projekt är en nativ Flutter-implementation av ExpressLRS kompilations- och flashningspipeline, designad att fungera helt offline.

## Förutsättningar
För att bidra till detta projekt behöver du följande verktyg installerade:

<div class="flex flex-wrap gap-2 my-6">
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Flutter SDK (Stable)</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Dart SDK</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Python 3.x</span>
  <span class="px-3 py-1 rounded-full bg-white/5 border border-white/10 text-text-muted text-xs font-bold transition-all hover:bg-white/10">Cocoapods (iOS/macOS)</span>
</div>

---

## Kom igång

1. **Klona repositoryt**:
   ```bash
   git clone https://github.com/wbhinton/ELRS-Mobile.git
   cd ELRS-Mobile
   ```

2. **Installera beroenden**:
   ```bash
   flutter pub get
   ```

3. **Kör applikationen**:
   ```bash
   # För Android
   flutter run
   
   # För iOS (kräver en Mac och fysisk enhet/simulator)
   flutter run
   ```

---

## Projektarkitektur
Kodbasen följer en funktionsfokuserad struktur som finns i `lib/src/`.

<div class="grid grid-cols-1 md:grid-cols-2 gap-4 lg:gap-6 my-8">
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M216,72H131.31L104,44.69A15.86,15.86,0,0,0,92.69,40H40A16,16,0,0,0,24,56V200a16,16,0,0,0,16,16H216a16,16,0,0,0,16-16V88A16,16,0,0,0,216,72Zm0,128H40V56H92.69l27.31,27.31A15.86,15.86,0,0,0,131.31,88H216Z"></path></svg>
      </div>
      Funktioner
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">flashing/</span>
        <span class="text-xs text-text-muted/70">Kärnlogiken och UI för flashing-pipelinen.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">firmware_manager/</span>
        <span class="text-xs text-text-muted/70">Hanterar nedladdning och cachning av firmware från artifactoryt.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">configurator/</span>
        <span class="text-xs text-text-muted/70">UI för att ställa in användaralternativ som Binding Phrases och WiFi.</span>
      </li>
    </ul>
  </div>
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path></svg>
      </div>
      Kärna
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">networking/</span>
        <span class="text-xs text-text-muted/70">Plattformsspecifik logik för processbindning till hårdvaru-hotspots.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">storage/</span>
        <span class="text-xs text-text-muted/70">Lokal cachehantering och SQLite-persistens.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">analytics/</span>
        <span class="text-xs text-text-muted/70">Integritetsfokuserad observerbarhet (Sentry och Aptabase).</span>
      </li>
    </ul>
  </div>
</div>

---

## Tillståndshantering
Vi använder **Riverpod** för global tillståndshantering och **Flutter Hooks** för lokal widget-nivå tillstånd. Denna kombination säkerställer ett mycket reaktivt användargränssnitt utan det tunga standardarbetet med `StatefulWidgets`.

---

## Fördjupningar

För mer detaljerad teknisk information, se följande guider:

- [**Teknisk Arkitektur**](/guides/technical_architecture): En fördjupning i `FirmwareAssembler` och den nativa nätverksstacken.
- [**Firmware-validering**](/guides/firmware-validation): Hur man använder Dart- och Python-verktygen för att verifiera binär integritet.

---

## Anmärkning om JSON-minifiering

Vid granskning av binärer kan du märka små byte-förskjutningar jämfört med den standardiserade Python Configurator. Detta beror på **JSON-minifiering**.

Python Configurator injicerar ofta mellanslag efter kolon (t.ex. `{"uid": [1,2,3]}`), medan ELRS Mobile genererar tät JSON (t.ex. `{"uid":[1,2,3]}`). Båda är funktionellt identiska på hårdvara, eftersom ESP32:s interna parser ignorerar detta mellanslag.

<!-- source_hash: 085cfe5b5087b4c76a42f1e288c0ba6e -->