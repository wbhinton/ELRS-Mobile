---
title: "Teknisk arkitektur"
slug: nb/technical_architecture
sidebar:
  order: 6
---

ELRS Mobile er ikke bare en web-innpakning; det er en nativ Dart-implementasjon av ExpressLRS kompilasjons- og konfigurasjons-pipeline.

<div class="px-6 py-6 my-8 rounded-2xl bg-surface/30 border border-white/5 shadow-2xl backdrop-blur-sm">
  <div class="flex items-center gap-3 mb-6">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M208,32H48A16,16,0,0,0,32,48V208a16,16,0,0,0,16,16H208a16,16,0,0,0,16-16V48A16,16,0,0,0,208,32Zm0,176H48V48H208V208ZM176,128a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,128Zm0-32a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,96Zm0,64a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,160Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-white m-0 tracking-tight">Samlet fastvaremontering</h3>
  </div>
  <p class="text-sm text-text-muted mb-6 leading-relaxed">
    I stedet for å stole på en ekstern skykompilator, bygger appen dynamisk binærfiler lokalt på enheten din. Når du flasher ESP32/ESP8285-mål, utfører <code>FirmwareAssembler</code> en presis bit-nivå modifikasjonssekvens:
  </p>
  <div class="grid grid-cols-1 gap-3">
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">1</span>
      <p class="text-xs text-text-muted/90 m-0">Trekker ut den generiske grunn-fastvaren fra det mellomlagrede <code>firmware.zip</code> arkivet.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">2</span>
      <p class="text-xs text-text-muted/90 m-0">Kutter grunn-utfyllingen ved å søke etter ESP <code>0xE9</code> magiske byte-signatur.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">3</span>
      <p class="text-xs text-text-muted/90 m-0">Trekker ut spesifikke målpinout og kjøretidskonfigurasjon fra <code>hardware.json</code>.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">4</span>
      <p class="text-xs text-text-muted/90 m-0">Byte-pakker Produktnavn (128b), Lua-navn (16b), <code>options.json</code> (512b), og <code>hardware.json</code> (2048b) direkte inn i binærstrømmen.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">5</span>
      <p class="text-xs text-text-muted/90 m-0">Komprimerer den endelige nyttelasten til en <code>.gz</code> strøm hvis det kreves av målplattformen (f.eks. ESP8285 legacy). </p>
    </div>
  </div>
</div>

## Perifer logikk

### Regulatorisk Domene-injektor
Appen håndterer nøyaktig de komplekse forskjellene mellom frekvensbånd. For 900MHz/Dual-Band-enheter injiserer den aktivt det valgte domenet ditt (f.eks. FCC, EU868) inn i den kompilerte JSON-nyttelasten. For standard 2.4GHz-mål bruker den et boolsk flagg for å stille rute uttrekks-prosessen til enten standard FCC/- eller europeiske LBT/-basefirmwaremapper under montering.

### Fastvaremellomlagring og synkronisering
Frakoblet flashing er gjort mulig gjennom et robust lokalt mellomlagringssystem. Når en bruker laster ned en utgivelse via Firmware Manager, henter `FirmwareCacheService` den generiske `firmware.zip` og enhetsspesifikke `hardware.zip` direkte fra ExpressLRS Artifactory. Disse arkivene administreres og lagres lokalt på enheten, noe som sikrer at montering og flashing kan skje umiddelbart i felten uten aktiv internettilkobling.

---

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm8,128a8,8,0,0,1-16,0V80a8,8,0,0,1,16,0Zm-8,40a12,12,0,1,1,12-12A12,12,0,0,1,128,192Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Nativ nettverksbinding</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    Mobile operativsystemer (spesielt Android og iOS) vil nedprioritere Wi-Fi-tilkoblinger som mangler internettilgang, og i stedet stille rute trafikk over mobildata. Dette hindrer standardapper i å nå ELRS-maskinvare på <code>10.0.0.1</code>.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    ELRS Mobile løser dette via <code>NativeNetworkService</code>. Når en maskinvaretilkobling oppdages, kaller appen opp en plattformspesifikk <code>MethodChannel</code> for å binde hele Flutter-prosessen til Wi-Fi-grensesnittet på OS-kjernenivå. Dette sikrer at all HTTP- og mDNS-trafikk rutes korrekt til maskinvaren, uavhengig av mobildatastatus.
  </p>
</div>

<!-- source_hash: e7995f5b2e9cae15ccd44e4e747d8f33 -->