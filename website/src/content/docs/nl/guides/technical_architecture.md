---
title: "Technische Architectuur"
slug: nl/technical_architecture
sidebar:
  order: 6
---

ELRS Mobile is niet zomaar een web-wrapper; het is een native Dart-implementatie van de ExpressLRS compilatie- en configuratiepipeline.

<div class="px-6 py-6 my-8 rounded-2xl bg-surface/30 border border-white/5 shadow-2xl backdrop-blur-sm">
  <div class="flex items-center gap-3 mb-6">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M208,32H48A16,16,0,0,0,32,48V208a16,16,0,0,0,16,16H208a16,16,0,0,0,16-16V48A16,16,0,0,0,208,32Zm0,176H48V48H208V208ZM176,128a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,128Zm0-32a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,96Zm0,64a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,160Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-white m-0 tracking-tight">Uniforme Firmware Assemblage</h3>
  </div>
  <p class="text-sm text-text-muted mb-6 leading-relaxed">
    In plaats van te vertrouwen op een compiler in de cloud op afstand, bouwt de app dynamisch binaries lokaal op uw apparaat. Bij het flashen van ESP32/ESP8285 targets, voert de <code>FirmwareAssembler</code> een precieze bit-level modificatievolgorde uit:
  </p>
  <div class="grid grid-cols-1 gap-3">
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">1</span>
      <p class="text-xs text-text-muted/90 m-0">Extraheert de generieke basisfirmware uit het gecachte <code>firmware.zip</code> archief.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">2</span>
      <p class="text-xs text-text-muted/90 m-0">Verwijdert de basispadding door de ESP <code>0xE9</code> magic byte signature te zoeken.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">3</span>
      <p class="text-xs text-text-muted/90 m-0">Extraheert specifieke target pinouts en runtime configuratie uit <code>hardware.json</code>.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">4</span>
      <p class="text-xs text-text-muted/90 m-0">Byte-packs Product Name (128b), Lua Name (16b), <code>options.json</code> (512b), en <code>hardware.json</code> (2048b) direct in de binaire stroom.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">5</span>
      <p class="text-xs text-text-muted/90 m-0">Comprimeert de uiteindelijke payload naar een <code>.gz</code> stroom indien vereist door het targetplatform (bijv. ESP8285 legacy). </p>
    </div>
  </div>
</div>

## Perifere Logica

### Regulatory Domain Injector
De app verwerkt nauwkeurig de complexe verschillen tussen frequentiebanden. Voor 900MHz/Dual-Band apparaten injecteert het actief uw gekozen domein (bijv. FCC, EU868) in de gecompileerde JSON-payload. Voor standaard 2.4GHz targets gebruikt het een booleaanse vlag om het extractieproces stilzwijgend te routeren naar ofwel de standaard FCC/ of Europese LBT/ basisfirmware-mappen tijdens de assemblage.

### Firmware Caching & Sync
Offline flashen wordt mogelijk gemaakt door een robuust lokaal cachingsysteem. Wanneer een gebruiker een release downloadt via de Firmware Manager, haalt de `FirmwareCacheService` de generieke `firmware.zip` en apparaatspecifieke `hardware.zip` rechtstreeks op uit de ExpressLRS Artifactory. Deze archieven worden lokaal op het apparaat beheerd en opgeslagen, waardoor assemblage en flashen direct in het veld kunnen plaatsvinden zonder actieve internetverbinding.

---

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm8,128a8,8,0,0,1-16,0V80a8,8,0,0,1,16,0Zm-8,40a12,12,0,1,1,12-12A12,12,0,0,1,128,192Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Native Netwerkbinding</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    Mobiele besturingssystemen (met name Android en iOS) zullen Wi-Fi-verbindingen zonder internettoegang deprioriteren, en in plaats daarvan stilzwijgend verkeer via mobiele data routeren. Dit voorkomt dat standaard apps ELRS-hardware op <code>10.0.0.1</code> kunnen bereiken.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    ELRS Mobile lost dit op via de <code>NativeNetworkService</code>. Wanneer een hardwareverbinding wordt gedetecteerd, roept de app een platformspecifieke <code>MethodChannel</code> aan om het hele Flutter-proces te binden aan de Wi-Fi-interface op OS-kernelniveau. Dit zorgt ervoor dat al het HTTP- en mDNS-verkeer correct naar de hardware wordt gerouteerd, ongeacht de mobiele status.
  </p>
</div>

<!-- source_hash: e7995f5b2e9cae15ccd44e4e747d8f33 -->