---
title: "Uživatelská příručka"
slug: user_guide
sidebar:
  order: 1
---

## Přehled
Tato aplikace poskytuje komplexní mobilní rozhraní pro správu hardwaru ExpressLRS. Umožňuje uživatelům konfigurovat parametry přijímače (RX) a vysílače (TX), mapovat výstupy PWM a flashovat aktualizace firmwaru přímo z mobilního zařízení.

---

## Instalace

### Oficiální obchody s aplikacemi

#### [Android](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile)
Nainstalujte z Google Play

<a href="https://play.google.com/store/apps/details?id=io.datarx.elrsmobile" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Získat na Google Play</a>

#### [iOS](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
Nainstalujte z App Store

<a href="https://apps.apple.com/us/app/elrs-mobile/id6760490014" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Stáhnout v App Store</a>

### Alternativní instalace

#### GitHub Store
Ideální pro uživatele, kteří preferují alternativní zkušenost s obchodem s aplikacemi.

<a href="https://github.com/OpenHub-Store/Github-Store" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Stáhnout v GitHub Store</a>

### Manuální instalace
Pro pokročilé uživatele nebo ty, kteří preferují manuální správu, navštivte naši stránku [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases) pro nejnovější soubory `.apk`.

---

## 🚀 Rychlý start: Flashování prvního zařízení

### Fáze 1: Kešování firmwaru (Proveďte to doma)
1. Otevřete aplikaci a přejděte do **Firmware Manageru**.
2. Klepněte na ikonu stahování vedle nejnovější stabilní verze.
3. Aplikace stáhne a bezpečně uloží do mezipaměti požadované cílové a hardwarové definice pro offline použití.

### Fáze 2: Připojení k zařízení
1. Zapněte svůj ExpressLRS přijímač (RX) nebo vysílač (TX).
2. Počkejte 60 sekund (nebo váš nakonfigurovaný interval), než zařízení přejde do režimu Wi-Fi Hotspot (rychle blikající LED).
3. Připojte Wi-Fi svého telefonu k síti **ExpressLRS RX** nebo **ExpressLRS TX** (Heslo: `expresslrs`).
4. Otevřete aplikaci. Dashboard automaticky prohledá síť pomocí mDNS a připojí se k zařízení.

### Fáze 3: Flashování firmwaru
1. Z Dashboardu vyberte **Flash Device**.
2. **Vyberte hardware:** Použijte rozbalovací nabídky k výběru typu zařízení, dodavatele, frekvence a cíle.
3. **Konfigurace možností a profilů:** Vyberte **Profil flashování** (nebo klepněte na tlačítko **+** pro přidání nového pojmenovaného profilu) pro načtení vašich přihlašovacích údajů. Přizpůsobte Binding Phrase, Wi-Fi SSID, Wi-Fi heslo, regulační domény a interval automatického zapnutí Wi-Fi.
4. Klepněte na **FLASH**. Aplikace sestaví binární soubor lokálně a nahraje jej do zařízení.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Upozornění na neshodu cíle</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Pokud aplikace detekuje neshodu hardwarového cíle mezi vaším výběrem a připojeným zařízením, upozorní vás, aby se zabránilo náhodnému poškození. Pokud jste si jisti, že máte správný cíl (např. obnova po špatném flashování nebo migrace mezi definicemi cíle), klikněte na <strong>FORCE FLASH</strong> v dialogovém okně upozornění pro obejití kontroly.
  </p>
</div>

### 📋 Správa profilů flashování
Pokud máte více dronů nebo rádiových sestav s různými konfiguračními požadavky (např. různé binding phrases nebo regulační domény), můžete použít pojmenované **Profily flashování** pro ukládání a přepínání konfigurací:
* **Přidat profil**: Klepněte na ikonu **+** vedle rozbalovací nabídky "Flashing Profile", zadejte název a klepněte na Přidat.
* **Automatické ukládání**: Jakékoli změny přihlašovacích údajů aktivního profilu (binding phrase, SSID, heslo, doména nebo interval) se ukládají automaticky v reálném čase.
* **Přepínání profilů**: Jednoduše vyberte profil z rozbalovací nabídky pro okamžité načtení jeho uložených nastavení.
* **Smazat profil**: Pro vyčištění vyberte profil z rozbalovací nabídky a klepněte na ikonu koše/smazání (pro smazání profilu musíte mít alespoň dva profily).

---

## Technické detaily

### Konektivita a objevování
Aplikace používá robustní vícestupňovou sekvenci objevování pro nalezení vašeho hardwaru:
1. **mDNS Resolution**: Primární metoda. Aplikace skenuje `elrs_rx.local` nebo `elrs_tx.local`.
2. **Static AP Fallback**: Pokud je mDNS blokováno, aplikace zkontroluje oficiální IP adresu přístupového bodu ELRS (`10.0.0.1`).
3. **Manual IP Override**: Pro komplexní sítě můžete ručně zadat IP adresu v Nastavení.

**Vynucené síťové vázání**: Moderní smartphony často odhazují Wi-Fi připojení bez internetu. ELRS Mobile obsahuje nativní vrstvu "Forced Routing", která nutí OS držet se hardwarového p��ipojení, což zajišťuje 100% spolehlivé objevování v terénu.

---

## Expertní režim a audit
V menu Nastavení mohou uživatelé povolit **Expertní režim**. To vám umožní uložit sestavený binární soubor firmwaru přímo do vašeho zařízení pro audit nebo ruční flashování přes FTDI.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Zacházení s hardwarem STM32</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Zatímco ELRS Mobile dokáže sestavit a patchovat firmware pro cíle STM32 (až do ELRS v3.x), tato zařízení nepodporují flashování Over-The-Air (OTA) přes Wi-Fi. Pokud vyberete cíl STM32, aplikace vám umožní sestavit a uložit binární soubor lokálně, abyste jej mohli flashovat ručně pomocí počítače přes STLink nebo Betaflight Passthrough.
  </p>
</div>

Pro vývojáře, kteří chtějí ověřit integritu těchto binárních souborů, se podívejte na našeho [**Průvodce ověřením firmwaru**](/guides/firmware-validation).

<!-- source_hash: 517ac115b41fa09bfaf858b0da950a2d -->