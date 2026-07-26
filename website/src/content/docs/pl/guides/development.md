---
title: "Przewodnik deweloperski"
description: Getting started with the ELRS Mobile codebase, project architecture, and developer workflows.
slug: pl/development
sidebar:
  order: 2
---

Witaj w przewodniku rozwoju ELRS Mobile! Ten projekt to natywna implementacja Fluttera potoku kompilacji i flashowania ExpressLRS, zaprojektowana do działania całkowicie offline.

## Wymagania wstępne
Aby przyczynić się do tego projektu, będziesz potrzebować zainstalowanych następujących narzędzi:

<div class="flex flex-wrap gap-2 my-6">
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Flutter SDK (Stabilna)</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Dart SDK</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Python 3.x</span>
  <span class="px-3 py-1 rounded-full bg-white/5 border border-white/10 text-text-muted text-xs font-bold transition-all hover:bg-white/10">Cocoapods (iOS/macOS)</span>
</div>

---

## Rozpoczęcie pracy

1. **Sklonuj repozytorium**:
   ```bash
   git clone https://github.com/wbhinton/ELRS-Mobile.git
   cd ELRS-Mobile
   ```

2. **Zainstaluj zależności**:
   ```bash
   flutter pub get
   ```

3. **Uruchom aplikację**:
   ```bash
   # Dla Androida
   flutter run
   
   # Dla iOS (wymaga Maca i urządzenia fizycznego/symulatora)
   flutter run
   ```

---

## Architektura projektu
Baza kodu ma strukturę zorientowaną na funkcje, zlokalizowaną w `lib/src/`.

<div class="grid grid-cols-1 md:grid-cols-2 gap-4 lg:gap-6 my-8">
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M216,72H131.31L104,44.69A15.86,15.86,0,0,0,92.69,40H40A16,16,0,0,0,24,56V200a16,16,0,0,0,16,16H216a16,16,0,0,0,16-16V88A16,16,0,0,0,216,72Zm0,128H40V56H92.69l27.31,27.31A15.86,15.86,0,0,0,131.31,88H216Z"></path></svg>
      </div>
      Funkcje
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">flashing/</span>
        <span class="text-xs text-text-muted/70">Główna logika i interfejs użytkownika dla potoku flashowania.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">firmware_manager/</span>
        <span class="text-xs text-text-muted/70">Zarządza pobieraniem i buforowaniem firmware z repozytorium artefaktów.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">configurator/</span>
        <span class="text-xs text-text-muted/70">Interfejs użytkownika do ustawiania opcji użytkownika, takich jak Binding Phrases i WiFi.</span>
      </li>
    </ul>
  </div>
  <div class="p-6 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm shadow-xl">
    <h3 class="text-lg font-bold text-white mb-5 flex items-center gap-3">
      <div class="p-1.5 rounded-lg bg-primary/10 text-primary">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path></svg>
      </div>
      Rdzeń
    </h3>
    <ul class="space-y-4 text-sm text-text-muted list-none pl-0 m-0">
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">networking/</span>
        <span class="text-xs text-text-muted/70">Logika specyficzna dla platformy do wiązania procesów z hotspotami sprzętowymi.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">storage/</span>
        <span class="text-xs text-text-muted/70">Zarządzanie lokalną pamięcią podręczną i trwałość SQLite.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">analytics/</span>
        <span class="text-xs text-text-muted/70">Obserwowalność zorientowana na prywatność (Sentry i Aptabase).</span>
      </li>
    </ul>
  </div>
</div>

---

## Zarządzanie stanem
Wykorzystujemy **Riverpod** do globalnego zarządzania stanem i **Flutter Hooks** do lokalnego stanu na poziomie widżetów. To połączenie zapewnia wysoce reaktywny interfejs użytkownika bez powtarzalnego kodu standardowych `StatefulWidgets`.

---

## Szczegółowe Analizy

Aby uzyskać bardziej szczegółowe informacje techniczne, zapoznaj się z poniższymi przewodnikami:

- [**Architektura Techniczna**](/guides/technical_architecture): Szczegółowa analiza `FirmwareAssembler` i natywnego stosu sieciowego.
- [**Walidacja Firmware**](/guides/firmware-validation): Jak używać narzędzi Dart i Python do weryfikacji integralności binarnej.

---

## Uwaga dotycząca minifikacji JSON

Podczas audytu plików binarnych możesz zauważyć niewielkie różnice w liczbie bajtów w porównaniu ze standardowym Configuratorem Python. Wynika to z **minifikacji JSON**. 

Configurator Python często wstawia spacje po dwukropkach (np. `{"uid": [1,2,3]}`), podczas gdy ELRS Mobile generuje gęsty JSON (np. `{"uid":[1,2,3]}`). Obie formy są funkcjonalnie identyczne na sprzęcie, ponieważ wewnętrzny parser ESP32 ignoruje te białe znaki.

<!-- source_hash: 085cfe5b5087b4c76a42f1e288c0ba6e -->