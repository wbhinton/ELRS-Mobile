---
title: "Technische Architektur"
slug: de/technical_architecture
sidebar:
  order: 6
---

ELRS Mobile ist nicht nur ein Web-Wrapper; es ist eine native Dart-Implementierung der ExpressLRS Kompilierungs- und Konfigurations-Pipeline.

<div class="px-6 py-6 my-8 rounded-2xl bg-surface/30 border border-white/5 shadow-2xl backdrop-blur-sm">
  <div class="flex items-center gap-3 mb-6">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M208,32H48A16,16,0,0,0,32,48V208a16,16,0,0,0,16,16H208a16,16,0,0,0,16-16V48A16,16,0,0,0,208,32Zm0,176H48V48H208V208ZM176,128a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,128Zm0-32a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,96Zm0,64a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,160Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-white m-0 tracking-tight">Vereinheitlichte Firmware-Zusammenstellung</h3>
  </div>
  <p class="text-sm text-text-muted mb-6 leading-relaxed">
    Anstatt sich auf einen entfernten Cloud-Compiler zu verlassen, erstellt die App Binärdateien dynamisch lokal auf Ihrem Gerät. Beim Flashen von ESP32/ESP8285 Zielen führt der <code>FirmwareAssembler</code> eine präzise Bit-Level-Modifikationssequenz aus:
  </p>
  <div class="grid grid-cols-1 gap-3">
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">1</span>
      <p class="text-xs text-text-muted/90 m-0">Extrahiert die generische Basis-Firmware aus dem gecachten <code>firmware.zip</code>-Archiv.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">2</span>
      <p class="text-xs text-text-muted/90 m-0">Entfernt die Basis-Auffüllung, indem die ESP <code>0xE9</code> Magic Byte Signatur gesucht wird.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">3</span>
      <p class="text-xs text-text-muted/90 m-0">Extrahiert spezifische Ziel-Pinbelegungen und Laufzeitkonfigurationen aus <code>hardware.json</code>.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">4</span>
      <p class="text-xs text-text-muted/90 m-0">Verpackt Produktname (128b), Lua Name (16b), <code>options.json</code> (512b) und <code>hardware.json</code> (2048b) direkt in den Binärstrom.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">5</span>
      <p class="text-xs text-text-muted/90 m-0">Komprimiert die endgültige Nutzlast in einen <code>.gz</code>-Stream, falls von der Zielplattform (z.B. ESP8285 legacy) erforderlich. </p>
    </div>
  </div>
</div>

## Peripherielogik

### Injektor für den Regulierungsbereich
Die App verarbeitet präzise die komplexen Unterschiede zwischen Frequenzbändern. Bei 900MHz/Dual-Band-Geräten injiziert sie aktiv Ihre gewählte Domäne (z.B. FCC, EU868) in die kompilierte JSON-Nutzlast. Für Standard-2.4GHz-Ziele verwendet sie ein boolesches Flag, um den Extraktionsprozess während der Montage stillschweigend entweder zu den Standard-FCC/- oder europäischen LBT/-Basis-Firmware-Ordnern zu leiten.

### Firmware-Caching & Synchronisierung
Offline-Flashing wird durch ein robustes lokales Caching-System ermöglicht. Wenn ein Benutzer eine Veröffentlichung über den Firmware Manager herunterlädt, zieht der `FirmwareCacheService` die generische `firmware.zip` und gerätespezifische `hardware.zip` direkt aus dem ExpressLRS Artifactory. Diese Archive werden lokal auf dem Gerät verwaltet und gespeichert, wodurch die Zusammenstellung und das Flashen sofort vor Ort ohne aktive Internetverbindung erfolgen können.

---

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm8,128a8,8,0,0,1-16,0V80a8,8,0,0,1,16,0Zm-8,40a12,12,0,1,1,12-12A12,12,0,0,1,128,192Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Native Netzwerkbindung</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    Mobile Betriebssysteme (insbesondere Android und iOS) depriorisieren Wi-Fi-Verbindungen ohne Internetzugang und leiten den Datenverkehr stattdessen stillschweigend über Mobilfunk. Dies verhindert, dass Standard-Apps die ELRS-Hardware unter <code>10.0.0.1</code> erreichen können.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    ELRS Mobile löst dies über den <code>NativeNetworkService</code>. Wenn eine Hardwareverbindung erkannt wird, ruft die App einen plattformspezifischen <code>MethodChannel</code> auf, um den gesamten Flutter-Prozess auf Kernel-Ebene des Betriebssystems an die Wi-Fi-Schnittstelle zu binden. Dies stellt sicher, dass der gesamte HTTP- und mDNS-Datenverkehr korrekt zur Hardware geleitet wird, unabhängig vom Mobilfunkstatus.
  </p>
</div>

<!-- source_hash: e7995f5b2e9cae15ccd44e4e747d8f33 -->