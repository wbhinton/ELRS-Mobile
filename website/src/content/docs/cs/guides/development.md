---
title: "Vývojová příručka"
description: Getting started with the ELRS Mobile codebase, project architecture, and developer workflows.
slug: development
sidebar:
  order: 2
---

Vítejte v průvodci vývojem ELRS Mobile! Tento projekt je nativní Flutter implementace pipeline kompilace a flashování ExpressLRS, navržená tak, aby fungovala zcela offline.

## Předpoklady
Pro přispívání k tomuto projektu budete potřebovat nainstalované následující nástroje:

<div class="flex flex-wrap gap-2 my-6">
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Flutter SDK (Stable)</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Dart SDK</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Python 3.x</span>
  <span class="px-3 py-1 rounded-full bg-white/5 border border-white/10 text-text-muted text-xs font-bold transition-all hover:bg-white/10">Cocoapods (iOS/macOS)</span>
</div>

---

## Začínáme

1.  **Klonování repozitáře**:
    ```bash
    git clone https://github.com/wbhinton/ELRS-Mobile.git
    cd ELRS-Mobile
    ```

2.  **Instalace závislostí**:
    ```bash
    flutter pub get
    ```

3.  **Spuštění aplikace**:
    ```bash
    # Pro Android
    flutter run
    
    # Pro iOS (vyžaduje Mac a fyzické zařízení/simulátor)
    flutter run
    ```

---

## Architektura projektu
Kódová základna se řídí strukturou orientovanou na funkce, která se nachází v `lib/src/`.

<div class="grid grid-cols-1 md:grid-cols-2 gap-4 lg:gap-6 my-8">
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M216,72H131.31L104,44.69A15.86,15.86,0,0,0,92.69,40H40A16,16,0,0,0,24,56V200a16,16,0,0,0,16,16H216a16,16,0,0,0,16-16V88A16,16,0,0,0,216,72Zm0,128H40V56H92.69l27.31,27.31A15.86,15.86,0,0,0,131.31,88H216Z"></path></svg>
      </div>
      Features
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">flashing/</span>
        <span class="text-xs text-text-muted/70">Základní logika a uživatelské rozhraní pro pipeline flashování.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">firmware_manager/</span>
        <span class="text-xs text-text-muted/70">Spravuje stahování a ukládání firmwaru z úložiště (artifactory).</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">configurator/</span>
        <span class="text-xs text-text-muted/70">Uživatelské rozhraní pro nastavení uživatelských možností jako Binding Phrases a WiFi.</span>
      </li>
    </ul>
  </div>
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path></svg>
      </div>
      Core
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">networking/</span>
        <span class="text-xs text-text-muted/70">Logika specifická pro platformu pro vázání procesů k hardwarovým hotspotům.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">storage/</span>
        <span class="text-xs text-text-muted/70">Správa lokální cache a perzistence SQLite.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">analytics/</span>
        <span class="text-xs text-text-muted/70">Observabilita s důrazem na soukromí (Sentry a Aptabase).</span>
      </li>
    </ul>
  </div>
</div>

---

## Správa stavu
Pro správu globálního stavu využíváme **Riverpod** a pro lokální stav na úrovni widgetů **Flutter Hooks**. Tato kombinace zajišťuje vysoce reaktivní uživatelské rozhraní bez složitosti standardních `StatefulWidgets`.

---

## Podrobné informace

Pro podrobnější technické informace se prosím podívejte na následující průvodce:

- [**Technická architektura**](/guides/technical_architecture): Podrobný pohled na `FirmwareAssembler` a nativní síťový zásobník.
- [**Validace firmwaru**](/guides/firmware-validation): Jak používat nástroje Dart a Python k ověření integrity binárních souborů.

---

## Poznámka k minifikaci JSONu

Při auditu binárních souborů si můžete všimnout mírných posunů bajtů ve srovnání se standardním Python Configuratorem. To je způsobeno **minifikací JSONu**.

Python Configurator často vkl��dá mezery za dvojtečky (např. `{"uid": [1,2,3]}`), zatímco ELRS Mobile generuje hustý JSON (např. `{"uid":[1,2,3]}`). Oba jsou na hardwaru funkčně identické, protože interní parser ESP32 tyto mezery ignoruje.

<!-- source_hash: 085cfe5b5087b4c76a42f1e288c0ba6e -->