---
title: "Architettura Tecnica"
slug: it/technical_architecture
sidebar:
  order: 6
---

ELRS Mobile non è solo un web-wrapper; è un'implementazione nativa in Dart della pipeline di compilazione e configurazione di ExpressLRS.

<div class="px-6 py-6 my-8 rounded-2xl bg-surface/30 border border-white/5 shadow-2xl backdrop-blur-sm">
  <div class="flex items-center gap-3 mb-6">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M208,32H48A16,16,0,0,0,32,48V208a16,16,0,0,0,16,16H208a16,16,0,0,0,16-16V48A16,16,0,0,0,208,32Zm0,176H48V48H208V208ZM176,128a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,128Zm0-32a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,96Zm0,64a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,160Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-white m-0 tracking-tight">Assemblaggio Firmware Unificato</h3>
  </div>
  <p class="text-sm text-text-muted mb-6 leading-relaxed">
    Invece di affidarsi a un compilatore cloud remoto, l'app costruisce dinamicamente i binari localmente sul tuo dispositivo. Quando si flashano i target ESP32/ESP8285, il <code>FirmwareAssembler</code> esegue una precisa sequenza di modifiche a livello di bit:
  </p>
  <div class="grid grid-cols-1 gap-3">
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">1</span>
      <p class="text-xs text-text-muted/90 m-0">Estrae il firmware generico di base dall'archivio <code>firmware.zip</code> in cache.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">2</span>
      <p class="text-xs text-text-muted/90 m-0">Rimuove il padding di base cercando la firma del magic byte <code>0xE9</code> di ESP.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">3</span>
      <p class="text-xs text-text-muted/90 m-0">Estrae pinout target specifici e configurazione di runtime da <code>hardware.json</code>.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">4</span>
      <p class="text-xs text-text-muted/90 m-0">Impacchetta direttamente nello stream binario il Nome Prodotto (128b), il Nome Lua (16b), <code>options.json</code> (512b) e <code>hardware.json</code> (2048b).</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">5</span>
      <p class="text-xs text-text-muted/90 m-0">Comprime il payload finale in uno stream <code>.gz</code> se richiesto dalla piattaforma target (es. ESP8285 legacy). </p>
    </div>
  </div>
</div>

## Logica Periferica

### Iniettore Dominio Regolatorio
L'app gestisce con precisione le complesse differenze tra le bande di frequenza. Per i dispositivi a 900MHz/Dual-Band, inietta attivamente il dominio scelto (es. FCC, EU868) nel payload JSON compilato. Per i target standard a 2.4GHz, utilizza un flag booleano per instradare silenziosamente il processo di estrazione alle cartelle del firmware base standard FCC/ o LBT/ europeo durante l'assemblaggio.

### Caching e Sincronizzazione Firmware
Il flashing offline è reso possibile tramite un robusto sistema di caching locale. Quando un utente scarica una release tramite il Firmware Manager, il `FirmwareCacheService` recupera il `firmware.zip` generico e il `hardware.zip` specifico del dispositivo direttamente dall'Artifactory di ExpressLRS. Questi archivi sono gestiti e archiviati localmente sul dispositivo, garantendo che l'assemblaggio e il flashing possano avvenire istantaneamente sul campo senza alcuna connessione internet attiva.

---

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm8,128a8,8,0,0,1-16,0V80a8,8,0,0,1,16,0Zm-8,40a12,12,0,1,1,12-12A12,12,0,0,1,128,192Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Binding di Rete Nativo</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    I sistemi operativi mobili (specialmente Android e iOS) deprioritizzano le connessioni Wi-Fi prive di accesso a internet, instradando silenziosamente il traffico sulla rete cellulare. Questo impedisce alle app standard di raggiungere l'hardware ELRS all'indirizzo <code>10.0.0.1</code>.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    ELRS Mobile risolve questo problema tramite il <code>NativeNetworkService</code>. Quando viene rilevata una connessione hardware, l'app invoca un <code>MethodChannel</code> specifico della piattaforma per associare l'intero processo Flutter all'interfaccia Wi-Fi a livello di kernel del sistema operativo. Ciò garantisce che tutto il traffico HTTP e mDNS venga instradato correttamente all'hardware, indipendentemente dallo stato della rete cellulare.
  </p>
</div>

<!-- source_hash: e7995f5b2e9cae15ccd44e4e747d8f33 -->