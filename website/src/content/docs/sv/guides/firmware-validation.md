---
title: "Firmware-valideringsverktyg"
description: Detailed documentation for the ExpressLRS Logic Validator and Ground Truth Auditor.
slug: firmware-validation
sidebar:
  order: 3
---

Denna guide beskriver de interna verktyg som används för att validera ELRS Mobile-applikationens logik för firmwaremontering mot officiella "Golden"-binärfiler.

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Ground Truth vs. Konfiguratorbinärfiler</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    När du utför valideringsrevisioner kan du märka att binärfiler genererade av ELRS Mobile perfekt matchar den officiella **ExpressLRS Web Flasher**, men avviker något från binärfiler byggda med den lokala **ExpressLRS Configurator (Python)**.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    Detta är förväntat beteende. ESP32:s interna C++ JSON-parser ignorerar tomrum, vilket innebär att båda binärfilerna körs identiskt på hårdvara trots att de misslyckas med en strikt byte-för-byte SHA256-jämförelse på grund av minifieringsskillnader.
  </p>
</div>

---

## 1. ExpressLRS Logic Validator (Dart)
**Plats:** `firmware_testing/scripts/dart/logic_validator.dart`

Logic Validator är ett högpresterande bit-nivå jämförelseverktyg. Det är utformat för att verifiera att ELRS Mobiles interna patchnings- och monteringslogik speglar den officiella ExpressLRS-logiken.

### Nyckelfunktioner
- **Bit-nivåanalys**: Lokaliserar exakta bit-offset-fel inom avvikande bytes.
- **Interaktivt val**: Listar alla binärfiler som finns i `firmware_testing/binaries/`.
- **Zero-Copy minneshantering**: Optimerad för höghastighetsanalys av stora firmwarefiler.

### Hur man använder
1. **Förbered binärfiler**: Placera de genererade `.bin`- eller `.gz`-filerna i `firmware_testing/binaries/`.
2. **Installation och körning**:
   ```bash
   cd firmware_testing/scripts/dart/
   dart pub get
   dart run logic_validator.dart
   ```

---

## 2. Ground Truth Auditor (Python)
**Plats:** `firmware_testing/scripts/python/audit_tool.py`

Auditor är ett fristående, noll-beroende skript avsett för "Ground Truth"-verifiering. Det parsar det 2704-byte stora konfigurationsblocket som läggs till i slutet av varje ExpressLRS firmware-avbildning.

### Syfte
Det verifierar att den metadata som faktiskt flashas till enheten (Product Name, Lua Name, Hardware Layout och Options) är korrekt, oavsett layoutskillnader i den grundläggande firmwarekoden.

### Hur man använder
1. **Kör direkt**:
   ```bash
   python3 firmware_testing/scripts/python/audit_tool.py [file1] [file2]
   ```

---

## 3. Arbetsflöde för binär korsvalidering
För att säkerställa att ELRS Mobile monterar firmware korrekt, bör utvecklare regelbundet utföra en korsvalideringsrevision mot en "Ground Truth"-binärfil som kompilerats på en PC.

<div class="space-y-4 my-8">
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">1</span>
      <h4 class="text-lg font-bold text-white m-0">Exportera binärfil från ELRS Mobile</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Aktivera **Expert Mode** i Inställningar, använd sedan knappen **DOWNLOAD BINARY** i fliken Flasher efter att du har konfigurerat din målenhet och dina alternativ.</p>
  </div>
  
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">2</span>
      <h4 class="text-lg font-bold text-white m-0">Generera PC Ground Truth</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Bygg **exakt samma** målenhet och version med identiska alternativ med hjälp av den officiella ExpressLRS Configurator på din PC.</p>
  </div>

  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">3</span>
      <h4 class="text-lg font-bold text-white m-0">Kör revisionen</h4>
    </div>
    <p class="text-sm text-text-muted ml-11">Placera båda binärfilerna i <code>firmware_testing/binaries/</code> och kör skriptet <code>audit_tool.py</code> för att verifiera perfekt hårdvaru- och optionsparitet.</p>
  </div>
</div>

<!-- source_hash: e81dc89571a3d0c4e16b7373b3ec0d47 -->