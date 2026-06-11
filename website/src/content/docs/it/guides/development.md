---
title: "Guida allo Sviluppo"
description: Getting started with the ELRS Mobile codebase, project architecture, and developer workflows.
slug: development
sidebar:
  order: 2
---

Benvenuti nella guida allo sviluppo di ELRS Mobile! Questo progetto è un'implementazione nativa Flutter della pipeline di compilazione e flashing di ExpressLRS, progettata per funzionare interamente offline.

## Prerequisiti
Per contribuire a questo progetto, avrai bisogno dei seguenti strumenti installati:

<div class="flex flex-wrap gap-2 my-6">
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Flutter SDK (Stabile)</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Dart SDK</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Python 3.x</span>
  <span class="px-3 py-1 rounded-full bg-white/5 border border-white/10 text-text-muted text-xs font-bold transition-all hover:bg-white/10">Cocoapods (iOS/macOS)</span>
</div>

---

## Per iniziare

1.  **Clona il repository**:
    ```bash
    git clone https://github.com/wbhinton/ELRS-Mobile.git
    cd ELRS-Mobile
    ```

2.  **Installa le dipendenze**:
    ```bash
    flutter pub get
    ```

3.  **Esegui l'applicazione**:
    ```bash
    # Per Android
    flutter run
    
    # Per iOS (richiede un Mac e un dispositivo fisico/simulatore)
    flutter run
    ```

---

## Architettura del Progetto
Il codice segue una struttura incentrata sulle funzionalità e si trova in `lib/src/`.

<div class="grid grid-cols-1 md:grid-cols-2 gap-4 lg:gap-6 my-8">
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M216,72H131.31L104,44.69A15.86,15.86,0,0,0,92.69,40H40A16,16,0,0,0,24,56V200a16,16,0,0,0,16,16H216a16,16,0,0,0,16-16V88A16,16,0,0,0,216,72Zm0,128H40V56H92.69l27.31,27.31A15.86,15.86,0,0,0,131.31,88H216Z"></path></svg>
      </div>
      Funzionalità
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">flashing/</span>
        <span class="text-xs text-text-muted/70">La logica principale e l'UI per la pipeline di flashing.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">firmware_manager/</span>
        <span class="text-xs text-text-muted/70">Gestisce il download e la cache del firmware dall'artifactory.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">configurator/</span>
        <span class="text-xs text-text-muted/70">UI per impostare le opzioni utente come Binding Phrases e WiFi.</span>
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
        <span class="text-xs text-text-muted/70">Logica specifica della piattaforma per il binding di processo a hotspot hardware.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">storage/</span>
        <span class="text-xs text-text-muted/70">Gestione della cache locale e persistenza SQLite.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">analytics/</span>
        <span class="text-xs text-text-muted/70">Osservabilità privacy-first (Sentry e Aptabase).</span>
      </li>
    </ul>
  </div>
</div>

---

## Gestione dello Stato
Utilizziamo **Riverpod** per la gestione dello stato globale e **Flutter Hooks** per lo stato a livello di widget locale. Questa combinazione assicura un'interfaccia utente altamente reattiva senza il boilerplate dei `StatefulWidgets` standard.

---

## Approfondimenti

Per informazioni tecniche più dettagliate, fare riferimento alle seguenti guide:

-   [**Architettura Tecnica**](/guides/technical_architecture): Un approfondimento sul `FirmwareAssembler` e lo stack di networking nativo.
-   [**Validazione del Firmware**](/guides/firmware-validation): Come utilizzare gli strumenti Dart e Python per verificare l'integrità binaria.

---

## Nota sulla Minificazione JSON

Quando si verificano i binari, si potrebbero notare leggere differenze di byte rispetto al Python Configurator standard. Ciò è dovuto alla **minificazione JSON**.

Il Python Configurator spesso inserisce spazi dopo i due punti (ad esempio, `{"uid": [1,2,3]}`), mentre ELRS Mobile genera JSON denso (ad esempio, `{"uid":[1,2,3]}`). Entrambi sono funzionalmente identici sull'hardware, poiché il parser interno dell'ESP32 ignora questo spazio bianco.

<!-- source_hash: 085cfe5b5087b4c76a42f1e288c0ba6e -->