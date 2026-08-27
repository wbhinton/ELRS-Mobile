---
title: "Firmware valideringsverktøy"
description: Detailed documentation for the ExpressLRS Logic Validator and Ground Truth Auditor.
slug: nb/firmware-validation
sidebar:
  order: 3
---

Denne guiden beskriver de interne verktøyene som brukes til å validere ELRS Mobile-applikasjonens logikk for fastvaremontering mot offisielle "Golden" binærfiler.

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Ground Truth vs. Konfigurator-binærfiler</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    Når du utfører valideringsrevisjoner, kan du legge merke til at binærfiler generert av ELRS Mobile stemmer perfekt overens med den offisielle <strong>ExpressLRS Web Flasher</strong>, men avviker litt fra binærfiler bygget ved hjelp av den lokale <strong>ExpressLRS Configurator (Python)</strong>.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    Dette er forventet oppførsel. ESP32s interne C++ JSON-parser ignorerer mellomrom, noe som betyr at begge binærfilene utføres identisk på maskinvare, til tross for at de feiler en streng byte-for-byte SHA256-sammenligning på grunn av minifieringsforskjeller.
  </p>
</div>

---

## 1. ExpressLRS Logic Validator (Dart)
**Sted:** `firmware_testing/scripts/dart/logic_validator.dart`

Logic Validator er et høyytelses bitnivå-sammenligningsverktøy. Det er designet for å verifisere at ELRS Mobiles interne patching- og monteringslogikk speiler den offisielle ExpressLRS-logikken.

### Nøkkelfunksjoner
- **Bitnivåanalyse**: Finner nøyaktige bit-offset-feil innenfor avvikende bytes.
- **Interaktivt utvalg**: Lister alle binærfiler funnet i `firmware_testing/binaries/`.
- **Zero-Copy minneadministrasjon**: Optimalisert for høyhastighetsanalyse av store fastvarefiler.

### Slik bruker du den
1. **Klargjør binærfiler**: Plasser de genererte `.bin`- eller `.gz`-filene i `firmware_testing/binaries/`.
2. **Oppsett og kjøring**:
   ```bash
   cd firmware_testing/scripts/dart/
   dart pub get
   dart run logic_validator.dart
   ```

---

## 2. Ground Truth Auditor (Python)
**Sted:** `firmware_testing/scripts/python/audit_tool.py`

Auditoren er et frittstående skript uten avhengigheter, beregnet for "Ground Truth"-verifisering. Det parser den 2704-byte store konfigurasjonsblokken som er lagt til slutten av hvert ExpressLRS fastvarebilde.

### Formål
Den verifiserer at metadataene som faktisk er flashet til enheten (Product Name, Lua Name, Hardware Layout og Options) er korrekte, uavhengig av eventuelle layoutforskjeller i den grunnleggende fastvarekoden.

### Slik bruker du den
1. **Kjør direkte**:
   ```bash
   python3 firmware_testing/scripts/python/audit_tool.py [file1] [file2]
   ```

---

## 3. Binær kryssvalideringsarbeidsflyt
For å sikre at ELRS Mobile monterer fastvare korrekt, bør utviklere periodisk utføre en kryssvalideringsrevisjon mot en "Ground Truth"-binærfil kompilert på en PC.

<div class="space-y-4 my-8">
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">1</span>
      <h4 class="text-lg font-bold text-white m-0">Eksporter binærfil fra ELRS Mobile</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Aktiver <strong>Expert Mode</strong> i Innstillinger, og bruk deretter <strong>DOWNLOAD BINARY</strong>-knappen i Flasher-fanen etter å ha konfigurert ditt mål og alternativer.</p>
  </div>
  
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">2</span>
      <h4 class="text-lg font-bold text-white m-0">Generer PC Ground Truth</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Bygg det <strong>nøyaktig samme</strong> målet og versjonen med identiske alternativer ved hjelp av den offisielle ExpressLRS Configurator på din PC.</p>
  </div>

  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">3</span>
      <h4 class="text-lg font-bold text-white m-0">Kjør revisjonen</h4>
    </div>
    <p class="text-sm text-text-muted ml-11">Plasser begge binærfilene i <code>firmware_testing/binaries/</code> og kjør skriptet `audit_tool.py` for å verifisere perfekt maskinvare- og alternativer-likhet.</p>
  </div>
</div>

<!-- source_hash: e81dc89571a3d0c4e16b7373b3ec0d47 -->