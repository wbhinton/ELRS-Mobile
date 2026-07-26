---
title: "Ontwikkelingsgids"
description: Getting started with the ELRS Mobile codebase, project architecture, and developer workflows.
slug: nl/development
sidebar:
  order: 2
---

Welkom bij de ontwikkelingsgids voor ELRS Mobile! Dit project is een native Flutter-implementatie van de ExpressLRS compilatie- en flitspijplijn, ontworpen om volledig offline te werken.

## Vereisten
Om bij te dragen aan dit project, heeft u de volgende tools geïnstalleerd nodig:

<div class="flex flex-wrap gap-2 my-6">
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Flutter SDK (Stable)</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Dart SDK</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Python 3.x</span>
  <span class="px-3 py-1 rounded-full bg-white/5 border border-white/10 text-text-muted text-xs font-bold transition-all hover:bg-white/10">Cocoapods (iOS/macOS)</span>
</div>

---

## Aan de slag

1. **Kloon de repository**:
   ```bash
   git clone https://github.com/wbhinton/ELRS-Mobile.git
   cd ELRS-Mobile
   ```

2. **Installeer afhankelijkheden**:
   ```bash
   flutter pub get
   ```

3. **Voer de applicatie uit**:
   ```bash
   # Voor Android
   flutter run
   
   # Voor iOS (vereist een Mac en een fysiek apparaat/simulator)
   flutter run
   ```

---

## Projectarchitectuur
De codebase volgt een feature-first structuur, te vinden in `lib/src/`.

<div class="grid grid-cols-1 md:grid-cols-2 gap-4 lg:gap-6 my-8">
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M216,72H131.31L104,44.69A15.86,15.86,0,0,0,92.69,40H40A16,16,0,0,0,24,56V200a16,16,0,0,0,16,16H216a16,16,0,0,0,16-16V88A16,16,0,0,0,216,72Zm0,128H40V56H92.69l27.31,27.31A15.86,15.86,0,0,0,131.31,88H216Z"></path></svg>
      </div>
      Functies
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">flashing/</span>
        <span class="text-xs text-text-muted/70">De kernlogica en UI voor de flashing-pijplijn.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">firmware_manager/</span>
        <span class="text-xs text-text-muted/70">Beheert het downloaden en cachen van firmware van de artifactory.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">configurator/</span>
        <span class="text-xs text-text-muted/70">UI voor het instellen van gebruikersopties zoals Binding Phrases en WiFi.</span>
      </li>
    </ul>
  </div>
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path></svg>
      </div>
      Kern
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">networking/</span>
        <span class="text-xs text-text-muted/70">Platformspecifieke logica voor procesbinding aan hardware-hotspots.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">storage/</span>
        <span class="text-xs text-text-muted/70">Lokaal cachebeheer en SQLite-persistentie.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">analytics/</span>
        <span class="text-xs text-text-muted/70">Privacy-eerst observeerbaarheid (Sentry en Aptabase).</span>
      </li>
    </ul>
  </div>
</div>

---

## Statusbeheer
We maken gebruik van **Riverpod** voor globaal statusbeheer en **Flutter Hooks** voor lokale widget-niveau status. Deze combinatie zorgt voor een zeer responsieve UI zonder de boilerplate van standaard `StatefulWidgets`.

---

## Diepgaande analyses

Voor meer gedetailleerde technische informatie, verwijzen wij u naar de volgende handleidingen:

- [**Technische Architectuur**](/guides/technical_architecture): Een diepgaande analyse van de `FirmwareAssembler` en de native netwerkstack.
- [**Firmware Validatie**](/guides/firmware-validation): Hoe de Dart- en Python-tools te gebruiken om binaire integriteit te verifiëren.

---

## Opmerking over JSON-minificatie

Bij het controleren van binaire bestanden kunt u kleine byte-offsets opmerken in vergelijking met de standaard Python Configurator. Dit komt door **JSON-minificatie**.

De Python Configurator voegt vaak spaties in na dubbele punten (bijv. `{"uid": [1,2,3]}`), terwijl ELRS Mobile dichte JSON genereert (bijv. `{"uid":[1,2,3]}`). Beide zijn functioneel identiek op hardware, aangezien de interne parser van de ESP32 deze witruimte negeert.

<!-- source_hash: 085cfe5b5087b4c76a42f1e288c0ba6e -->