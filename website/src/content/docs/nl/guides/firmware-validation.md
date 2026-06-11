---
title: "Firmware Validatie Tools"
description: Detailed documentation for the ExpressLRS Logic Validator and Ground Truth Auditor.
slug: firmware-validation
sidebar:
  order: 3
---

Deze gids beschrijft de interne tools die worden gebruikt om de firmware-assemblagelogica van de ELRS Mobile-applicatie te valideren tegen officiële "Golden" binaries.

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Grondwaarheid vs. Configurator Binaries</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    Bij het uitvoeren van validatieaudits, zult u misschien merken dat binaries die zijn gegenereerd door ELRS Mobile perfect overeenkomen met de officiële <strong>ExpressLRS Web Flasher</strong>, maar enigszins afwijken van binaries die zijn gebouwd met de lokale <strong>ExpressLRS Configurator (Python)</strong>.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    Dit is verwacht gedrag. De interne C++ JSON-parser van de ESP32 negeert witruimte, wat betekent dat beide binaries identiek worden uitgevoerd op hardware, ondanks dat ze een strikte byte-voor-byte SHA256-vergelijking niet doorstaan als gevolg van verschillen in minificatie.
  </p>
</div>

---

## 1. ExpressLRS Logic Validator (Dart)
**Locatie:** `firmware_testing/scripts/dart/logic_validator.dart`

De Logic Validator is een krachtige vergelijkingstool op bit-niveau. Het is ontworpen om te verifiëren dat de interne patch- en assemblagelogica van ELRS Mobile de officiële ExpressLRS-logica weerspiegelt.

### Belangrijkste Kenmerken
- **Bit-Niveau Analyse**: Lokaliseert exacte bit-offset fouten binnen afwijkende bytes.
- **Interactieve Selectie**: Toont alle binaries gevonden in `firmware_testing/binaries/`.
- **Zero-Copy Geheugenbeheer**: Geoptimaliseerd voor snelle analyse van grote firmwarebestanden.

### Hoe te Gebruiken
1. **Bereid Binaries Voor**: Plaats de gegenereerde `.bin` of `.gz` bestanden in `firmware_testing/binaries/`.
2. **Setup & Uitvoeren**:
   ```bash
   cd firmware_testing/scripts/dart/
   dart pub get
   dart run logic_validator.dart
   ```

---

## 2. Ground Truth Auditor (Python)
**Locatie:** `firmware_testing/scripts/python/audit_tool.py`

De Auditor is een op zichzelf staand, zero-dependency script bedoeld voor "Ground Truth" verificatie. Het parset het 2704-byte configuratieblok dat aan het einde van elke ExpressLRS firmware-image is toegevoegd.

### Doel
Het verifieert dat de metadata die daadwerkelijk naar het apparaat is geflashed (Product Name, Lua Name, Hardware Layout, en Opties) correct is, ongeacht eventuele layoutverschillen in de basis firmwarecode.

### Hoe te Gebruiken
1. **Direct uitvoeren**:
   ```bash
   python3 firmware_testing/scripts/python/audit_tool.py [file1] [file2]
   ```

---

## 3. Workflow voor Binaire Cross-Validatie
Om ervoor te zorgen dat ELRS Mobile firmware correct assembleert, moeten ontwikkelaars periodiek een cross-validatieaudit uitvoeren tegen een "Ground Truth" binary die is gecompileerd op een pc.

<div class="space-y-4 my-8">
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">1</span>
      <h4 class="text-lg font-bold text-white m-0">Exporteer Binary vanuit ELRS Mobile</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Schakel <strong>Expertmodus</strong> in bij Instellingen en gebruik vervolgens de knop <strong>DOWNLOAD BINARY</strong> in het tabblad Flasher na het configureren van uw target en opties.</p>
  </div>
  
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">2</span>
      <h4 class="text-lg font-bold text-white m-0">Genereer PC Grondwaarheid</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Bouw <strong>exact dezelfde</strong> target en versie met identieke opties met behulp van de officiële ExpressLRS Configurator op uw pc.</p>
  </div>

  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">3</span>
      <h4 class="text-lg font-bold text-white m-0">Voer de Audit uit</h4>
    </div>
    <p class="text-sm text-text-muted ml-11">Plaats beide binaries in <code>firmware_testing/binaries/</code> en voer het <code>audit_tool.py</code>-script uit om perfecte hardware- en optiepariteit te verifiëren.</p>
  </div>
</div>

<!-- source_hash: e81dc89571a3d0c4e16b7373b3ec0d47 -->