---
title: "Nástroje pro validaci firmwaru"
description: Detailed documentation for the ExpressLRS Logic Validator and Ground Truth Auditor.
slug: cs/firmware-validation
sidebar:
  order: 3
---

Tato příručka podrobně popisuje interní nástroje používané k ověření logiky sestavení firmwaru aplikace ELRS Mobile proti oficiálním "zlatým" binárním souborům.

<div class="p-6 my-10 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-4">
    <div class="p-2.5 rounded-xl bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 256 256"><path d="M216,40V216a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V40a8,8,0,0,1,8-8H208A8,8,0,0,1,216,40Zm-16,8H56V208H200ZM160,88a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,88Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,120Zm0,32a8,8,0,0,1-8,8H104a8,8,0,0,1,0-16h48A8,8,0,0,1,160,152Z"></path></svg>
    </div>
    <h3 class="text-xl font-bold text-primary m-0 tracking-tight">Pravdivá data vs. binární soubory konfigurátoru</h3>
  </div>
  <p class="text-sm leading-relaxed text-text-muted pl-12 mb-4">
    Při provádění validačních auditů si můžete všimnout, že binární soubory generované ELRS Mobile se dokonale shodují s oficiálním <strong>ExpressLRS Web Flasherem</strong>, ale mírně se liší od binárních souborů vytvořených pomocí lokálního <strong>ExpressLRS Configuratoru (Python)</strong>.
  </p>
  <p class="text-sm leading-relaxed text-text-muted pl-12 m-0">
    Toto je očekávané chování. Interní C++ JSON parser v ESP32 ignoruje mezery, což znamená, že oba binární soubory se na hardwaru spouštějí identicky, přestože selžou při přísném porovnání SHA256 bajt po bajtu kvůli rozdílům v minifikaci.
  </p>
</div>

---

## 1. Validátor logiky ExpressLRS (Dart)
**Location:** `firmware_testing/scripts/dart/logic_validator.dart`

Validátor logiky je vysoce výkonný nástroj pro bitové porovnávání. Je navržen tak, aby ověřil, že interní logika patchování a sestavování ELRS Mobile odráží oficiální logiku ExpressLRS.

### Klíčové vlastnosti
- **Analýza na bitové úrovni**: Určuje přesné bitové chyby v nesouhlasících bajtech.
- **Interaktivní výběr**: Zobrazuje seznam všech binárních souborů nalezených v `firmware_testing/binaries/`.
- **Správa paměti s nulovou kopií**: Optimalizováno pro vysokorychlostní analýzu velkých souborů firmwaru.

### Jak používat
1. **Připravte binární soubory**: Umístěte vygenerované soubory `.bin` nebo `.gz` do `firmware_testing/binaries/`.
2. **Nastavení a spuštění**:
   ```bash
   cd firmware_testing/scripts/dart/
   dart pub get
   dart run logic_validator.dart
   ```

---

## 2. Auditor pravdivých dat (Python)
**Location:** `firmware_testing/scripts/python/audit_tool.py`

Auditor je samostatný skript bez závislostí, určený pro ověření "pravdivých dat". Analyzuje 2704bajtový konfigurační blok připojený na konec každého obrazu firmwaru ExpressLRS.

### Účel
Ověřuje, že metadata skutečně flashnutá do zařízení (Product Name, Lua Name, Hardware Layout a Options) jsou správná, bez ohledu na rozdíly v rozvržení v základním kódu firmwaru.

### Jak používat
1. **Spusťte přímo**:
   ```bash
   python3 firmware_testing/scripts/python/audit_tool.py [file1] [file2]
   ```

---

## 3. Pracovní postup binární křížové validace
Aby bylo zajištěno, že ELRS Mobile správně sestavuje firmware, měli by vývojáři pravidelně provádět audit křížové validace proti binárnímu souboru "pravdivých dat" zkompilovanému na PC.

<div class="space-y-4 my-8">
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">1</span>
      <h4 class="text-lg font-bold text-white m-0">Export binárního souboru z ELRS Mobile</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Povolte <strong>Expert Mode</strong> v Nastavení a poté použijte tlačítko <strong>DOWNLOAD BINARY</strong> v záložce Flasher po konfiguraci vašeho cíle a Options.</p>
  </div>
  
  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">2</span>
      <h4 class="text-lg font-bold text-white m-0">Vygenerujte PC pravdivá data</h4>
    </div>
    <p class="text-sm text-text-muted ml-11 mb-4">Sestavte <strong>úplně stejný</strong> cíl a verzi s identickými Options pomocí oficiálního ExpressLRS Configuratoru na vašem PC.</p>
  </div>

  <div class="p-5 rounded-2xl bg-surface/30 border border-white/5 backdrop-blur-sm">
    <div class="flex items-center gap-3 mb-4">
      <span class="w-8 h-8 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold">3</span>
      <h4 class="text-lg font-bold text-white m-0">Spusťte audit</h4>
    </div>
    <p class="text-sm text-text-muted ml-11">Umístěte oba binární soubory do <code>firmware_testing/binaries/</code> a spusťte skript <code>audit_tool.py</code> pro ověření dokonalé hardwarové a Options parity.</p>
  </div>
</div>

<!-- source_hash: e81dc89571a3d0c4e16b7373b3ec0d47 -->