---
title: "Gebruikershandleiding"
slug: user_guide
sidebar:
  order: 1
---

## Overzicht
Deze applicatie biedt een uitgebreide mobiele interface voor het beheren van ExpressLRS hardware. Het stelt gebruikers in staat om ontvanger (RX) en zender (TX) parameters te configureren, PWM-uitgangen toe te wijzen en firmware-updates direct vanaf een mobiel apparaat te flashen.

---

## Installatie

### Officiële App Stores

#### [Android](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile)
Installeer via Google Play

<a href="https://play.google.com/store/apps/details?id=io.datarx.elrsmobile" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Get it on Google Play</a>

#### [iOS](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
Installeer via de App Store

<a href="https://apps.apple.com/us/app/elrs-mobile/id6760490014" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Download on App Store</a>

### Alternatieve Installatie

#### GitHub Store
Ideaal voor gebruikers die een alternatieve app store-ervaring prefereren.

<a href="https://github.com/OpenHub-Store/Github-Store" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Download on GitHub Store</a>

### Handmatige Installatie
Voor ervaren gebruikers of degenen die handmatig beheer prefereren, bezoek onze [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases) pagina voor de nieuwste `.apk` bestanden.

---

## 🚀 Snelle Start: Je Eerste Apparaat Flashen

### Fase 1: Firmware Cachen (Doe dit thuis)
1. Open de app en navigeer naar de **Firmware Manager**.
2. Tik op het download-icoon naast de nieuwste stabiele release.
3. De app downloadt en cachet veilig de benodigde doel- en hardwaredenities voor offline gebruik.

### Fase 2: Verbinden met Je Apparaat
1. Schakel je ExpressLRS Receiver (RX) of Transmitter (TX) in.
2. Wacht 60 seconden (of je geconfigureerde interval) tot het apparaat de Wi-Fi Hotspot Modus binnengaat (snel knipperende LED).
3. Verbind de Wi-Fi van je telefoon met het **ExpressLRS RX** of **ExpressLRS TX** netwerk (Wachtwoord: `expresslrs`).
4. Open de app. Het Dashboard scant automatisch het netwerk met behulp van mDNS en maakt verbinding met het apparaat.

### Fase 3: Firmware Flashen
1. Selecteer vanuit het Dashboard **Flash Device**.
2. **Selecteer je Hardware:** Gebruik de trapsgewijze dropdowns om je Apparaattype, Leverancier, Frequentie en Doel te selecteren.
3. **Configureer Opties:** Stel je aangepaste Binding Phrase, Wi-Fi credentials en Regulatory Domain in.
4. Tik op **FLASH**. De app assembleert de binary lokaal en pusht deze naar het apparaat.

---

## Technische Details

### Connectiviteit & Ontdekking
De app gebruikt een robuuste meertraps ontdekkingssequentie om je hardware te vinden:
1. **mDNS Resolutie**: De primaire methode. De app scant naar `elrs_rx.local` of `elrs_tx.local`.
2. **Statische AP Terugval**: Als mDNS geblokkeerd is, controleert de app het officiële ELRS access point IP (`10.0.0.1`).
3. **Handmatige IP-override**: Voor complexe netwerken kun je handmatig een IP-adres invoeren in Instellingen.

**Geforceerde Netwerkbinding**: Moderne smartphones verbreken vaak Wi-Fi verbindingen zonder internet. ELRS Mobile bevat een native "Forced Routing" laag die het besturingssysteem dwingt om vast te houden aan de hardwareverbinding, wat 100% betrouwbare ontdekking in het veld garandeert.

---

## Expertmodus & Auditing
Binnen het Instellingen-menu kunnen gebruikers de **Expertmodus** inschakelen. Hiermee kunt u de geassembleerde firmware-binary direct op uw apparaat opslaan voor auditing of handmatig flashen via FTDI.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">STM32 Hardware Beheer</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Hoewel ELRS Mobile firmware kan assembleren en patchen voor STM32 targets (tot ELRS v3.x), ondersteunen deze apparaten geen Over-The-Air (OTA) flashing via Wi-Fi. Als u een STM32 target selecteert, stelt de app u in staat om de binary lokaal te bouwen en op te slaan, zodat u deze handmatig kunt flashen met een PC via STLink of Betaflight Passthrough.
  </p>
</div>

Voor ontwikkelaars die de integriteit van deze binaries willen verifiëren, zie onze [**Firmware Validatiegids**](/guides/firmware-validation).

<!-- source_hash: 3f2df9eced3639c7160ef043b20c909c -->