---
title: "Firmware Validierungstools"
description: Detailed documentation for the ExpressLRS Logic Validator and Ground Truth Auditor.
slug: firmware-validation
sidebar:
  order: 3
---

Dieser Leitfaden beschreibt die internen Tools, die verwendet werden, um die Firmware-Assemblierungslogik der ELRS Mobile-Anwendung anhand offizieller „Golden“-Binärdateien zu validieren.

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Ground Truth vs. Konfigurator-Binärdateien</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    Bei der Durchführung von Validierungsprüfungen werden Sie möglicherweise feststellen, dass von ELRS Mobile generierte Binärdateien perfekt mit dem offiziellen <strong>ExpressLRS Web Flasher</strong> übereinstimmen, sich jedoch geringfügig von Binärdateien unterscheiden, die mit dem lokalen <strong>ExpressLRS Configurator (Python)</strong> erstellt wurden.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    Dies ist ein erwartetes Verhalten. Der interne C++ JSON-Parser des ESP32 ignoriert Leerzeichen, was bedeutet, dass beide Binärdateien auf der Hardware identisch ausgeführt werden, obwohl sie einen strengen Byte-für-Byte-SHA256-Vergleich aufgrund von Minifizierungsunterschieden nicht bestehen.
  </p>
</div>

---

## 1. ExpressLRS Logic Validator (Dart)
**Speicherort:** `firmware_testing/scripts/dart/logic_validator.dart`

Der Logic Validator ist ein leistungsstarkes Bit-Ebenen-Vergleichstool. Es wurde entwickelt, um zu überprüfen, ob die interne Patching- und Assemblierungslogik von ELRS Mobile die offizielle ExpressLRS-Logik widerspiegelt.

### Hauptfunktionen
- **Bit-Ebenen-Analyse**: Identifiziert exakte Bit-Offset-Fehler innerhalb abweichender Bytes.
- **Interaktive Auswahl**: Listet alle in `firmware_testing/binaries/` gefundenen Binärdateien auf.
- **Zero-Copy Speicherverwaltung**: Optimiert für die Hochgeschwindigkeitsanalyse großer Firmware-Dateien.

### Anwendung
1. **Binärdateien vorbereiten**: Legen Sie die generierten `.bin`- oder `.gz`-Dateien in `firmware_testing/binaries/` ab.
2. **Einrichten & Ausführen**:
   ```bash
   cd firmware_testing/scripts/dart/
   dart pub get
   dart run logic_validator.dart
   ```

---

## 2. Ground Truth Auditor (Python)
**Speicherort:** `firmware_testing/scripts/python/audit_tool.py`

Der Auditor ist ein eigenständiges, abhängigkeitsfreies Skript zur „Ground Truth“-Verifizierung. Es analysiert den 2704 Byte großen Konfigurationsblock, der an jedes ExpressLRS-Firmware-Image angehängt ist.

### Zweck
Es überprüft, ob die tatsächlich auf das Gerät geflashten Metadaten (Product Name, Lua Name, Hardware Layout und Options) korrekt sind, unabhängig von etwaigen Layout-Unterschieden im Basis-Firmware-Code.

### Anwendung
1. **Direkt ausführen**:
   ```bash
   python3 firmware_testing/scripts/python/audit_tool.py [file1] [file2]
   ```

---

## 3. Binärer Kreuzvalidierungs-Workflow
Um sicherzustellen, dass ELRS Mobile Firmware korrekt zusammenstellt, sollten Entwickler regelmäßig eine Kreuzvalidierungsprüfung anhand einer „Ground Truth“-Binärdatei durchführen, die auf einem PC kompiliert wurde.

<div class="space-y-4 my-8">
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">1</span>
      <h4 class="text-lg font-bold text-white m-0">Binärdatei aus ELRS Mobile exportieren</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Aktivieren Sie den <strong>Expert Mode</strong> in den Einstellungen und verwenden Sie dann die Schaltfläche <strong>DOWNLOAD BINARY</strong> im Flasher-Tab, nachdem Sie Ihr Ziel und Ihre Optionen konfiguriert haben.</p>
  </div>
  
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">2</span>
      <h4 class="text-lg font-bold text-white m-0">PC Ground Truth generieren</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Erstellen Sie das <strong>genau gleiche</strong> Ziel und die gleiche Version mit identischen Optionen mit dem offiziellen ExpressLRS Configurator auf Ihrem PC.</p>
  </div>

  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">3</span>
      <h4 class="text-lg font-bold text-white m-0">Die Prüfung durchführen</h4>
    </div>
    <p class="text-sm text-text-muted ml-11">Legen Sie beide Binärdateien in <code>firmware_testing/binaries/</code> ab und führen Sie das Skript <code>audit_tool.py</code> aus, um eine perfekte Hardware- und Optionsparität zu überprüfen.</p>
  </div>
</div>

<!-- source_hash: e81dc89571a3d0c4e16b7373b3ec0d47 -->