---
title: "Technická architektura"
slug: technical_architecture
sidebar:
  order: 6
---

ELRS Mobile není jen webový obal; je to nativní implementace Dartu pro kompilační a konfigurační pipeline ExpressLRS.

<div class="px-6 py-6 my-8 rounded-2xl bg-surface/30 border border-white/5 shadow-2xl backdrop-blur-sm">
  <div class="flex items-center gap-3 mb-6">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M208,32H48A16,16,0,0,0,32,48V208a16,16,0,0,0,16,16H208a16,16,0,0,0,16-16V48A16,16,0,0,0,208,32Zm0,176H48V48H208V208ZM176,128a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,128Zm0-32a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,96Zm0,64a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,160Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-white m-0 tracking-tight">Jednotné sestavení firmwaru</h3>
  </div>
  <p class="text-sm text-text-muted mb-6 leading-relaxed">
    Namísto spoléhání se na vzdálený cloudový kompilátor, aplikace dynamicky vytváří binární soubory lokálně na vašem zařízení. Při flashování cílů ESP32/ESP8285, <code>FirmwareAssembler</code> provádí přesnou sekvenci modifikace na bitové úrovni:
  </p>
  <div class="grid grid-cols-1 gap-3">
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">1</span>
      <p class="text-xs text-text-muted/90 m-0">Extrahování základního generického firmwaru z archivované archivu <code>firmware.zip</code>.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">2</span>
      <p class="text-xs text-text-muted/90 m-0">Oříznutí základní výplně vyhledáním signatury magického bajtu <code>0xE9</code> ESP.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">3</span>
      <p class="text-xs text-text-muted/90 m-0">Extrahování specifických pinoutů cíle a konfigurace za běhu z <code>hardware.json</code>.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">4</span>
      <p class="text-xs text-text-muted/90 m-0">Zabalení názvu produktu (128b), názvu Lua (16b), <code>options.json</code> (512b) a <code>hardware.json</code> (2048b) přímo do binárního proudu.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">5</span>
      <p class="text-xs text-text-muted/90 m-0">Komprese finálního payloadu do proudu <code>.gz</code>, pokud to vyžaduje cílová platforma (např. ESP8285 legacy).</p>
    </div>
  </div>
</div>

## Periferní logika

### Injektor regulační domény
Aplikace přesně zpracovává složité rozdíly mezi frekvenčními pásmy. U zařízení 900MHz/Dual-Band aktivně injektuje zvolenou doménu (např. FCC, EU868) do kompilovaného JSON payloadu. Pro standardní 2.4GHz cíle využívá booleovskou vlajku, aby během sestavování tiše směrovala proces extrakce buď do standardních složek základního firmwaru FCC/ nebo evropských LBT/.

### Ukládání a synchronizace firmwaru do mezipaměti
Offline flashování je umožněno robustním lokálním systémem ukládání do mezipaměti. Když uživatel stáhne vydání přes Firmware Manager, <code>FirmwareCacheService</code> stahuje generický <code>firmware.zip</code> a soubor <code>hardware.zip</code> specifický pro zařízení přímo z ExpressLRS Artifactory. Tyto archivy jsou spravovány a ukládány lokálně na zařízení, což zajišťuje, že sestavování a flashování může proběhnout okamžitě v terénu bez aktivního připojení k internetu.

---

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm8,128a8,8,0,0,1-16,0V80a8,8,0,0,1,16,0Zm-8,40a12,12,0,1,1,12-12A12,12,0,1,1,128,192Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Nativní síťová vazba</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    Mobilní operační systémy (zejména Android a iOS) budou snižovat prioritu Wi-Fi připojení, která postrádají přístup k internetu, a tiše směrovat provoz přes mobilní síť. To brání standardním aplikacím v přístupu k hardwaru ELRS na <code>10.0.0.1</code>.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    ELRS Mobile to řeší prostřednictvím <code>NativeNetworkService</code>. Když je detekováno hardwarové připojení, aplikace vyvolá <code>MethodChannel</code> specifický pro platformu, aby svázala celý proces Flutteru s Wi-Fi rozhraním na úrovni jádra OS. To zajišťuje, že veškerý HTTP a mDNS provoz se správně směruje k hardwaru, bez ohledu na stav mobilní sítě.
  </p>
</div>

<!-- source_hash: e7995f5b2e9cae15ccd44e4e747d8f33 -->