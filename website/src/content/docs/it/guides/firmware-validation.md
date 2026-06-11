---
title: "Strumenti di validazione Firmware"
description: Detailed documentation for the ExpressLRS Logic Validator and Ground Truth Auditor.
slug: firmware-validation
sidebar:
  order: 3
---

Questa guida descrive in dettaglio gli strumenti interni utilizzati per convalidare la logica di assemblaggio del firmware dell'applicazione ELRS Mobile rispetto ai binari "Golden" ufficiali.

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Verità Fondamentale vs. Binari del Configurator</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    Quando si eseguono audit di convalida, si potrebbe notare che i binari generati da ELRS Mobile corrispondono perfettamente all'ufficiale <strong>ExpressLRS Web Flasher</strong>, ma divergono leggermente dai binari costruiti utilizzando il <strong>ExpressLRS Configurator (Python)</strong> locale.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    Questo è un comportamento atteso. Il parser JSON C++ interno dell'ESP32 ignora gli spazi bianchi, il che significa che entrambi i binari vengono eseguiti in modo identico sull'hardware nonostante falliscano un confronto SHA256 rigoroso byte per byte a causa di differenze di minificazione.
  </p>
</div>

---

## 1. ExpressLRS Logic Validator (Dart)
**Posizione:** `firmware_testing/scripts/dart/logic_validator.dart`

Il Logic Validator è uno strumento di confronto ad alte prestazioni a livello di bit. È progettato per verificare che la logica di patching e assemblaggio interna di ELRS Mobile rispecchi la logica ufficiale di ExpressLRS.

### Caratteristiche Principali
- **Analisi a Livello di Bit**: Individua i guasti esatti dell'offset di bit all'interno di byte discrepanti.
- **Selezione Interattiva**: Elenca tutti i binari trovati in `firmware_testing/binaries/`.
- **Gestione della Memoria Zero-Copy**: Ottimizzata per l'analisi ad alta velocità di file firmware di grandi dimensioni.

### Come Usare
1. **Prepara i Binari**: Posiziona i file `.bin` o `.gz` generati in `firmware_testing/binaries/`.
2. **Configurazione ed Esecuzione**:
   ```bash
   cd firmware_testing/scripts/dart/
   dart pub get
   dart run logic_validator.dart
   ```

---

## 2. Ground Truth Auditor (Python)
**Posizione:** `firmware_testing/scripts/python/audit_tool.py`

L'Auditor è uno script autonomo, senza dipendenze, inteso per la verifica della "Verità Fondamentale". Analizza il blocco di configurazione di 2704 byte aggiunto alla fine di ogni immagine firmware di ExpressLRS.

### Scopo
Verifica che i metadati effettivamente flashati sul dispositivo (Product Name, Lua Name, Hardware Layout e Options) siano corretti, indipendentemente da eventuali differenze di layout nel codice firmware di base.

### Come Usare
1. **Esegui direttamente**:
   ```bash
   python3 firmware_testing/scripts/python/audit_tool.py [file1] [file2]
   ```

---

## 3. Flusso di Lavoro di Convalida Incrociata dei Binari
Per assicurarsi che ELRS Mobile stia assemblando correttamente il firmware, gli sviluppatori dovrebbero eseguire periodicamente un audit di convalida incrociata rispetto a un binario "Ground Truth" compilato su un PC.

<div class="space-y-4 my-8">
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">1</span>
      <h4 class="text-lg font-bold text-white m-0">Esporta Binario da ELRS Mobile</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Abilita la <strong>Modalità Esperto</strong> nelle Impostazioni, quindi usa il pulsante <strong>DOWNLOAD BINARY</strong> nella scheda Flasher dopo aver configurato il tuo target e le opzioni.</p>
  </div>
  
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">2</span>
      <h4 class="text-lg font-bold text-white m-0">Genera la Verità Fondamentale per PC</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Compila lo <strong>stesso identico</strong> target e versione con opzioni identiche usando l'ExpressLRS Configurator ufficiale sul tuo PC.</p>
  </div>

  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">3</span>
      <h4 class="text-lg font-bold text-white m-0">Esegui l'Audit</h4>
    </div>
    <p class="text-sm text-text-muted ml-11">Posiziona entrambi i binari in <code>firmware_testing/binaries/</code> ed esegui lo script <code>audit_tool.py</code> per verificare la perfetta parità di hardware e opzioni.</p>
  </div>
</div>

<!-- source_hash: e81dc89571a3d0c4e16b7373b3ec0d47 -->