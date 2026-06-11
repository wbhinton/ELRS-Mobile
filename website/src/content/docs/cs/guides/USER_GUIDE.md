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
Instalujte z Google Play

<a href="https://play.google.com/store/apps/details?id=io.datarx.elrsmobile" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Získejte na Google Play</a>

#### [iOS](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
Instalujte z App Store

<a href="https://apps.apple.com/us/app/elrs-mobile/id6760490014" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Stáhněte si z App Store</a>

### Alternativní instalace

#### GitHub Store
Ideální pro uživatele, kteří preferují alternativní zkušenost s obchodem aplikací.

<a href="https://github.com/OpenHub-Store/Github-Store" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Stáhněte si z GitHub Store</a>

### Manuální instalace
Pro zkušené uživatele nebo ty, kteří preferují manuální správu, navštivte naši stránku [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases) pro nejnovější soubory `.apk`.

---

## 🚀 Rychlý start: Flashování prvního zařízení

### Fáze 1: Cachování firmwaru (Proveďte doma)
1. Otevřete aplikaci a přejděte do **Správce firmwaru**.
2. Klepněte na ikonu stahování vedle nejnovější stabilní verze.
3. Aplikace stáhne a bezpečně uloží do mezipaměti požadované cílové a hardwarové definice pro offline použití.

### Fáze 2: Připojení k vašemu zařízení
1. Zapněte váš ExpressLRS Receiver (RX) nebo Transmitter (TX).
2. Počkejte 60 sekund (nebo na vámi nakonfigurovaný interval), než zařízení přejde do režimu Wi-Fi Hotspot (rychle blikající LED).
3. Připojte Wi-Fi telefonu k síti **ExpressLRS RX** nebo **ExpressLRS TX** (Heslo: `expresslrs`).
4. Otevřete aplikaci. Dashboard automaticky prohledá síť pomocí mDNS a připojí se k zařízení.

### Fáze 3: Flashování firmwaru
1. Z Dashboardu vyberte **Flash Device**.
2. **Vyberte svůj hardware:** Pomocí kaskádových rozbalovacích nabídek vyberte typ zařízení, výrobce, frekvenci a cíl.
3. **Konfigurujte možnosti:** Nastavte si vlastní Binding Phrase, Wi-Fi pověření a Regulatory Domain.
4. Klepněte na **FLASH**. Aplikace sestaví binární soubor lokálně a nahraje jej do zařízení.

---

## Technické detaily

### Konektivita a detekce
Aplikace používá robustní vícestupňovou sekvenci detekce k nalezení vašeho hardwaru:
1. **mDNS Resolution**: Primární metoda. Aplikace skenuje `elrs_rx.local` nebo `elrs_tx.local`.
2. **Static AP Fallback**: Pokud je mDNS blokováno, aplikace zkontroluje oficiální IP adresu přístupového bodu ELRS (`10.0.0.1`).
3. **Manual IP Override**: Pro komplexní sítě můžete ručně zadat IP adresu v nastavení.

**Forced Network Binding**: Moderní smartphony často odhazují Wi-Fi připojení bez internetu. ELRS Mobile obsahuje nativní vrstvu "Forced Routing", která nutí operační systém držet se hardwarového připojení a zajišťuje 100% spolehlivou detekci v terénu.

---

## Expert Mode a Auditování
V menu Nastavení mohou uživatelé povolit **Expert Mode**. To vám umožní uložit sestavený binární soubor firmwaru přímo do vašeho zařízení pro auditování nebo manuální flashování pomocí FTDI.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Správa hardwaru STM32</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Zatímco ELRS Mobile dokáže sestavovat a patchovat firmware pro cíle STM32 (až do ELRS v3.x), tato zařízení nepodporují Over-The-Air (OTA) flashování přes Wi-Fi. Pokud vyberete cíl STM32, aplikace vám umožní sestavit a uložit binární soubor lokálně, abyste jej mohli flashovat manuálně pomocí PC přes STLink nebo Betaflight Passthrough.
  </p>
</div>

Pro vývojáře, kteří chtějí ověřit integritu těchto binárních souborů, se podívejte na náš [**Průvodce ověřením firmwaru**](/guides/firmware-validation).

<!-- source_hash: 3f2df9eced3639c7160ef043b20c909c -->