---
title: "Architektura Techniczna"
slug: pl/technical_architecture
sidebar:
  order: 6
---

ELRS Mobile to nie tylko web-wrapper; to natywna implementacja w Dart potoku kompilacji i konfiguracji ExpressLRS.

<div class="px-6 py-6 my-8 rounded-2xl bg-surface/30 border border-white/5 shadow-2xl backdrop-blur-sm">
  <div class="flex items-center gap-3 mb-6">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M208,32H48A16,16,0,0,0,32,48V208a16,16,0,0,0,16,16H208a16,16,0,0,0,16-16V48A16,16,0,0,0,208,32Zm0,176H48V48H208V208ZM176,128a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,128Zm0-32a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,96Zm0,64a8,8,0,0,1-8,8H88a8,8,0,0,1,0-16h80A8,8,0,0,1,176,160Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-white m-0 tracking-tight">Zunifikowane składanie oprogramowania układowego</h3>
  </div>
  <p class="text-sm text-text-muted mb-6 leading-relaxed">
    Zamiast polegać na zdalnym kompilatorze chmurowym, aplikacja dynamicznie buduje binaria lokalnie na Twoim urządzeniu. Podczas flashowania celów ESP32/ESP8285, `FirmwareAssembler` wykonuje precyzyjną sekwencję modyfikacji na poziomie bitowym:
  </p>
  <div class="grid grid-cols-1 gap-3">
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">1</span>
      <p class="text-xs text-text-muted/90 m-0">Wyodrębnia bazowe, ogólne oprogramowanie układowe ze zarchiwizowanej pamięci podręcznej `firmware.zip`.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">2</span>
      <p class="text-xs text-text-muted/90 m-0">Przycina bazowe wypełnienie, szukając sygnatury magicznego bajtu ESP `0xE9`.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">3</span>
      <p class="text-xs text-text-muted/90 m-0">Wyodrębnia specyficzne dla celu pinouty i konfigurację czasu wykonania z `hardware.json`.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">4</span>
      <p class="text-xs text-text-muted/90 m-0">Pakuje nazwy produktów (128b), nazwę Lua (16b), `options.json` (512b) i `hardware.json` (2048b) bezpośrednio do strumienia binarnego.</p>
    </div>
    <div class="flex gap-4 p-4 rounded-xl bg-white/5 border border-white/5 transition-colors hover:bg-white/[0.07]">
      <span class="flex-shrink-0 w-6 h-6 rounded-full bg-primary/20 text-primary flex items-center justify-center text-xs font-bold">5</span>
      <p class="text-xs text-text-muted/90 m-0">Kompresuje ostateczny ładunek do strumienia `.gz`, jeśli jest to wymagane przez platformę docelową (np. ESP8285 legacy).</p>
    </div>
  </div>
</div>

## Logika peryferyjna

### Iniektor domeny regulacyjnej
Aplikacja precyzyjnie radzi sobie ze złożonymi różnicami między pasmami częstotliwości. W przypadku urządzeń 900MHz/Dual-Band, aktywnie wstrzykuje wybraną domenę (np. FCC, EU868) do skompilowanego ładunku JSON. Dla standardowych celów 2.4GHz, wykorzystuje flagę boolean, aby cicho przekierować proces ekstrakcji do standardowych folderów oprogramowania układowego FCC/ lub europejskich LBT/ podczas montażu.

### Buforowanie i synchronizacja oprogramowania układowego
Flashowanie offline jest możliwe dzięki solidnemu lokalnemu systemowi buforowania. Gdy użytkownik pobiera wydanie za pośrednictwem Firmware Managera, `FirmwareCacheService` pobiera ogólne `firmware.zip` i specyficzne dla urządzenia `hardware.zip` bezpośrednio z ExpressLRS Artifactory. Archiwa te są zarządzane i przechowywane lokalnie na urządzeniu, zapewniając natychmiastowe montaż i flashowanie w terenie, bez aktywnego połączenia internetowego.

---

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm8,128a8,8,0,0,1-16,0V80a8,8,0,0,1,16,0Zm-8,40a12,12,0,1,1,12-12A12,12,0,0,1,128,192Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Natywne wiązanie sieciowe</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    Mobilne systemy operacyjne (zwłaszcza Android i iOS) obniżają priorytet połączeń Wi-Fi bez dostępu do internetu, cicho kierując ruch przez sieć komórkową. Zapobiega to dostępowi standardowych aplikacji do sprzętu ELRS pod adresem `10.0.0.1`.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    ELRS Mobile rozwiązuje ten problem za pomocą `NativeNetworkService`. Gdy wykryte zostanie połączenie ze sprzętem, aplikacja wywołuje specyficzny dla platformy `MethodChannel`, aby powiązać cały proces Flutter z interfejsem Wi-Fi na poziomie jądra systemu operacyjnego. Zapewnia to, że cały ruch HTTP i mDNS jest poprawnie kierowany do sprzętu, niezależnie od statusu połączenia komórkowego.
  </p>
</div>

<!-- source_hash: e7995f5b2e9cae15ccd44e4e747d8f33 -->