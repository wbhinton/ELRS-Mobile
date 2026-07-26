---
title: "Entwicklungsleitfaden"
description: Getting started with the ELRS Mobile codebase, project architecture, and developer workflows.
slug: de/development
sidebar:
  order: 2
---

Willkommen zum ELRS Mobile Entwicklungsleitfaden! Dieses Projekt ist eine native Flutter-Implementierung der ExpressLRS Kompilierungs- und Flash-Pipeline, die vollständig offline funktioniert.

## Voraussetzungen
Um zu diesem Projekt beitragen zu können, müssen die folgenden Tools installiert sein:

<div class="flex flex-wrap gap-2 my-6">
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Flutter SDK (Stable)</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Dart SDK</span>
  <span class="px-3 py-1 rounded-full bg-primary/10 border border-primary/20 text-primary text-xs font-bold transition-all hover:bg-primary/20">Python 3.x</span>
  <span class="px-3 py-1 rounded-full bg-white/5 border border-white/10 text-text-muted text-xs font-bold transition-all hover:bg-white/10">Cocoapods (iOS/macOS)</span>
</div>

---

## Erste Schritte

1.  **Repository klonen**:
    ```bash
    git clone https://github.com/wbhinton/ELRS-Mobile.git
    cd ELRS-Mobile
    ```

2.  **Abhängigkeiten installieren**:
    ```bash
    flutter pub get
    ```

3.  **Anwendung ausführen**:
    ```bash
    # Für Android
    flutter run
    
    # Für iOS (erfordert einen Mac und ein physisches Gerät/Simulator)
    flutter run
    ```

---

## Projektarchitektur
Die Codebasis folgt einer Feature-First-Struktur und befindet sich in `lib/src/`.

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
        <span class="text-xs text-text-muted/70">Die Kernlogik und UI für die Flash-Pipeline.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">firmware_manager/</span>
        <span class="text-xs text-text-muted/70">Verwaltet das Herunterladen und Caching von Firmware aus dem Artifactory.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">configurator/</span>
        <span class="text-xs text-text-muted/70">UI zum Festlegen von Benutzeroptionen wie Binding Phrases und WiFi.</span>
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
        <span class="text-xs text-text-muted/70">Plattformspezifische Logik für die Prozessbindung an Hardware-Hotspots.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">storage/</span>
        <span class="text-xs text-text-muted/70">Lokale Cache-Verwaltung und SQLite-Persistenz.</span>
      </li>
      <li class="flex flex-col gap-1">
        <span class="font-bold text-white/90">analytics/</span>
        <span class="text-xs text-text-muted/70">Datenschutzorientierte Beobachtbarkeit (Sentry und Aptabase).</span>
      </li>
    </ul>
  </div>
</div>

---

## Zustandsverwaltung
Wir verwenden **Riverpod** für die globale Zustandsverwaltung und **Flutter Hooks** für den lokalen, Widget-Level-Zustand. Diese Kombination sorgt für eine hochreaktive Benutzeroberfläche ohne den Boilerplate-Code von Standard-`StatefulWidgets`.

---

## Detaillierte Einblicke

Für detailliertere technische Informationen beachten Sie bitte die folgenden Anleitungen:

-   [**Technical Architecture**](/guides/technical_architecture): Ein tiefer Einblick in den `FirmwareAssembler` und den nativen Netzwerk-Stack.
-   [**Firmware Validation**](/guides/firmware-validation): Wie man die Dart- und Python-Tools zur Überprüfung der binären Integrität verwendet.

---

## Hinweis zur JSON Minifizierung

Bei der Prüfung von Binärdateien können Sie geringfügige Byte-Abweichungen im Vergleich zum Standard Python Configurator feststellen. Dies liegt an der **JSON minification**.

Der Python Configurator fügt oft Leerzeichen nach Doppelpunkten ein (z. B. `{"uid": [1,2,3]}`), während ELRS Mobile dichtes JSON generiert (z. B. `{"uid":[1,2,3]}`). Beide sind auf der Hardware funktional identisch, da der interne Parser des ESP32 diese Leerzeichen ignoriert.

<!-- source_hash: 085cfe5b5087b4c76a42f1e288c0ba6e -->