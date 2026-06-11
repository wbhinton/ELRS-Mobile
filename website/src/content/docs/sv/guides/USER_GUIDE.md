---
title: "Användarhandbok"
slug: user_guide
sidebar:
  order: 1
---

## Översikt
Denna applikation tillhandahåller ett omfattande mobilgränssnitt för att hantera ExpressLRS-hårdvara. Den gör det möjligt för användare att konfigurera mottagar- (RX) och sändar- (TX) parametrar, mappa PWM-utgångar och flasha firmwareuppdateringar direkt från en mobil enhet.

---

## Installation

### Officiella Appbutiker

#### [Android](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile)
Installera från Google Play

<a href="https://play.google.com/store/apps/details?id=io.datarx.elrsmobile" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Skaffa den på Google Play</a>

#### [iOS](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
Installera från App Store

<a href="https://apps.apple.com/us/app/elrs-mobile/id6760490014" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Ladda ner i App Store</a>

### Alternativ Installation

#### GitHub Store
Idealisk för användare som föredrar en alternativ appbutiksupplevelse.

<a href="https://github.com/OpenHub-Store/Github-Store" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Ladda ner på GitHub Store</a>

### Manuell Installation
För avancerade användare eller de som föredrar manuell hantering, besök vår [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases) sida för de senaste `.apk`-filerna.

---

## 🚀 Snabbstart: Flashning av din första enhet

### Fas 1: Cachelagra Firmware (Gör detta hemma)
1. Öppna appen och navigera till **Firmware Manager**.
2. Tryck på nedladdningsikonen bredvid den senaste stabila versionen.
3. Appen kommer att ladda ner och säkert cachelagra de nödvändiga mål- och hårdvarudefinitionerna för offline-användning.

### Fas 2: Ansluta till din enhet
1. Slå på din ExpressLRS mottagare (RX) eller sändare (TX).
2. Vänta 60 sekunder (eller ditt konfigurerade intervall) tills enheten går in i Wi-Fi Hotspot-läge (snabbt blinkande LED).
3. Anslut din telefons Wi-Fi till nätverket **ExpressLRS RX** eller **ExpressLRS TX** (Lösenord: `expresslrs`).
4. Öppna appen. Dashboard kommer automatiskt att skanna nätverket med hjälp av mDNS och ansluta till enheten.

### Fas 3: Flasha Firmware
1. Från Dashboard, välj **Flash Device**.
2. **Välj din Hårdvara:** Använd de kaskaderande rullgardinsmenyerna för att välja din enhetstyp (Device Type), leverantör (Vendor), frekvens (Frequency) och mål (Target).
3. **Konfigurera Alternativ:** Ställ in din anpassade Binding Phrase, Wi-Fi-uppgifter (credentials) och Regulatory Domain.
4. Tryck på **FLASH**. Appen kommer att montera den binära filen lokalt och skicka den till enheten.

---

## Tekniska Detaljer

### Anslutning & Upptäckt
Appen använder en robust upptäcktssekvens i flera steg för att hitta din hårdvara:
1. **mDNS Resolution**: Den primära metoden. Appen söker efter `elrs_rx.local` eller `elrs_tx.local`.
2. **Static AP Fallback**: Om mDNS blockeras, kontrollerar appen den officiella ELRS accesspunktens IP (`10.0.0.1`).
3. **Manuell IP-åsidosättning**: För komplexa nätverk kan du manuellt ange en IP-adress i Inställningar.

**Forced Network Binding**: Moderna smartphones släpper ofta Wi-Fi-anslutningar utan internet. ELRS Mobile inkluderar ett inbyggt "Forced Routing"-lager som tvingar operativsystemet att hålla fast vid hårdvaruanslutningen, vilket säkerställer 100% tillförlitlig upptäckt i fält.

---

## Expertläge & Granskning
Inom Inställningar-menyn kan användare aktivera **Expertläge**. Detta gör att du kan spara den sammansatta firmware-binären direkt till din enhet för granskning eller manuell flashning via FTDI.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">STM32 Hårdvaruhantering</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Även om ELRS Mobile kan montera och patcha firmware för STM32-mål (upp till ELRS v3.x), stöder dessa enheter inte Over-The-Air (OTA) flashning via Wi-Fi. Om du väljer ett STM32-mål, kommer appen att låta dig bygga och spara den binära filen lokalt så att du kan flasha den manuellt med en PC via STLink eller Betaflight Passthrough.
  </p>
</div>

För utvecklare som vill verifiera integriteten hos dessa binärer, se vår [**Firmwarevalideringsguide**](/guides/firmware-validation).

<!-- source_hash: 3f2df9eced3639c7160ef043b20c909c -->