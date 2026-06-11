---
title: "Teknisk Arkitektur"
slug: technical_architecture
sidebar:
  order: 6
---

ELRS Mobile är inte bara en webb-wrapper; det är en nativ Dart-implementation av ExpressLRS kompilering- och konfigurationspipeline.

<div class="px-6 py-6 my-8 rounded-2xl bg-surface/30 border border-white/5 shadow-2xl backdrop-blur-sm">
  <div class="flex items-center gap-3 mb-6">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M208,32H48A16,16,0,0,0,32,48V208a16,16,0,0,0,16,16H208a16,16,0,0,0,16-16V48A16,16,0,0,0,208,32Zm0,176H48V48H208V208ZM176,128a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,128Zm0-32a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,96Zm0,64a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,160Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-white m-0 tracking-tight">Enhetlig Firmwaremontering</h3>
  </div>
  <p class="text-sm text-text-muted mb-6 leading-relaxed">
    Istället för att förlita sig på en fjärrbaserad molnkompilator, bygger appen dynamiskt binärer lokalt på din enhet. Vid flashning av ESP32/ESP8285-mål, utför <code>FirmwareAssembler</code> en precis bit-nivå modifieringssekvens:
  </p>
  <div class="grid grid-cols-1 gap-3">
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">1</span>
      <p class="text-xs text-text-muted/90 m-0">Extraherar den generiska basfirmwaren från det cachade <code>firmware.zip</code>-arkivet.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">2</span>
      <p class="text-xs text-text-muted/90 m-0">Trimmar basutfyllnaden genom att söka efter ESP <code>0xE9</code> magic byte-signaturen.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">3</span>
      <p class="text-xs text-text-muted/90 m-0">Extraherar specifika mål-pinouts och körningskonfiguration från <code>hardware.json</code>.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">4</span>
      <p class="text-xs text-text-muted/90 m-0">Byte-packar Produktnamn (128b), Lua-namn (16b), <code>options.json</code> (512b), och <code>hardware.json</code> (2048b) direkt in i den binära strömmen.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">5</span>
      <p class="text-xs text-text-muted/90 m-0">Komprimerar den slutliga nyttolasten till en <code>.gz</code>-ström om det krävs av målplattformen (t.ex. ESP8285 legacy). </p>
    </div>
  </div>
</div>

## Periferilogi

### Regulatorisk Domäninjektor
Appen hanterar noggrant de komplexa skillnaderna mellan frekvensband. För 900MHz/Dual-Band-enheter injicerar den aktivt din valda domän (t.ex. FCC, EU868) i den kompilerade JSON-nyttolasten. För standard 2.4GHz-mål använder den en boolean-flagga för att tyst dirigera extraktionsprocessen till antingen standard FCC/- eller europeiska LBT/-basfirmwaremappar under monteringen.

### Firmware-cachning & Synkronisering
Offline-flashning möjliggörs genom ett robust lokalt cachingsystem. När en användare laddar ner en utgåva via Firmware Manager, hämtar <code>FirmwareCacheService</code> den generiska <code>firmware.zip</code> och enhetsspecifika <code>hardware.zip</code> direkt från ExpressLRS Artifactory. Dessa arkiv hanteras och lagras lokalt på enheten, vilket säkerställer att montering och flashning kan ske omedelbart i fält utan någon aktiv internetanslutning.

---

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm8,128a8,8,0,0,1-16,0V80a8,8,0,0,1,16,0Zm-8,40a12,12,0,1,1,12-12A12,12,0,1,1,128,192Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Nativ Nätverksbindning</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    Mobila operativsystem (särskilt Android och iOS) kommer att nedprioritera Wi-Fi-anslutningar som saknar internetåtkomst, och tyst dirigera trafik över mobilnätet istället. Detta förhindrar standardappar från att nå ELRS-hårdvara på <code>10.0.0.1</code>.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    ELRS Mobile löser detta via <code>NativeNetworkService</code>. När en hårdvaruanslutning upptäcks, anropar appen en plattformsspecifik <code>MethodChannel</code> för att binda hela Flutter-processen till Wi-Fi-gränssnittet på OS-kärnnivå. Detta säkerställer att all HTTP- och mDNS-trafik dirigeras korrekt till hårdvaran, oavsett mobilstatus.
  </p>
</div>

<!-- source_hash: e7995f5b2e9cae15ccd44e4e747d8f33 -->