---
title: "Gebruikershandleiding"
slug: nl/user_guide
sidebar:
  order: 1
---

## Overzicht
Deze applicatie biedt een uitgebreide mobiele interface voor het beheer van ExpressLRS hardware. Het stelt gebruikers in staat om parameters van ontvanger (RX) en zender (TX) te configureren, PWM-uitgangen toe te wijzen, en firmware-updates direct vanaf een mobiel apparaat te flashen.

---

## Installatie

### Officiële App Stores

#### [Android](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile)
Installeren via Google Play

<a href="https://play.google.com/store/apps/details?id=io.datarx.elrsmobile" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Downloaden via Google Play</a>

#### [iOS](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
Installeren via de App Store

<a href="https://apps.apple.com/us/app/elrs-mobile/id6760490014" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Downloaden via de App Store</a>

### Alternatieve Installatie

#### GitHub Store
Ideaal voor gebruikers die een alternatieve app store-ervaring prefereren.

<a href="https://github.com/OpenHub-Store/Github-Store" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Downloaden via GitHub Store</a>

### Handmatige Installatie
Voor ervaren gebruikers of degenen die handmatig beheer prefereren, bezoek onze [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases) pagina voor de nieuwste `.apk` bestanden.

---

## 🚀 Snelle Start: Je Eerste Apparaat Flashen

### Fase 1: Firmware Cachen (Doe dit thuis)
1. Open de app en navigeer naar de **Firmware Manager**.
2. Tik op het downloadpictogram naast de nieuwste stabiele release.
3. De app downloadt en cachet veilig de vereiste target- en hardwaredefinities voor offline gebruik.

### Fase 2: Verbinding Maken met Je Apparaat
1. Schakel je ExpressLRS ontvanger (RX) of zender (TX) in.
2. Wacht 60 seconden (of je geconfigureerde interval) totdat het apparaat in Wi-Fi Hotspot-modus komt (snel knipperende LED).
3. Verbind de Wi-Fi van je telefoon met het **ExpressLRS RX** of **ExpressLRS TX** netwerk (Wachtwoord: `expresslrs`).
4. Open de app. Het Dashboard scant automatisch het netwerk via mDNS en maakt verbinding met het apparaat.

### Fase 3: Firmware Flashen
1. Selecteer vanuit het Dashboard **Flash Device**.
2. **Selecteer je Hardware:** Gebruik de trapsgewijze dropdowns om je Apparaattype, Leverancier, Frequentie en Target te selecteren.
3. **Opties & Profielen Configureren:** Selecteer een **Flashing Profile** (of tik op de **+** knop om een nieuw benoemd profiel toe te voegen) om je gegevens te laden. Pas de Binding Phrase, Wi-Fi SSID, Wi-Fi wachtwoord, reguliere domeinen en Wi-Fi auto-aan interval aan.
4. Tik op **FLASH**. De app assembleert de binary lokaal en pusht deze naar het apparaat.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Waarschuwing Target Mismatch</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Als de app een hardware target mismatch detecteert tussen je selectie en het verbonden apparaat, zal het je waarschuwen om accidentele schade te voorkomen. Als je zeker weet dat je de juiste target hebt (bijv. herstellen van een slechte flash of migreren tussen targetdefinities), klik dan op <strong>FORCE FLASH</strong> in het waarschuwingsvenster om de controle te omzeilen.
  </p>
</div>

### 📋 Flashing Profielen Beheren
Als je meerdere drones of radio-opstellingen hebt met verschillende configuratievereisten (bijv. verschillende binding phrases of reguliere domeinen), kun je benoemde **Flashing Profielen** gebruiken om configuraties op te slaan en te wisselen:
* **Profiel Toevoegen**: Tik op het **+** pictogram naast de "Flashing Profile" dropdown, typ een naam en druk op Toevoegen.
* **Auto-Opslaan**: Elke wijziging aan de gegevens van het actieve profiel (binding phrase, SSID, wachtwoord, domein of interval) wordt automatisch in realtime opgeslagen.
* **Profielen Wisselen**: Selecteer eenvoudigweg een profiel uit de dropdown om de opgeslagen instellingen direct te laden.
* **Profiel Verwijderen**: Om op te ruimen, selecteer je het profiel uit de dropdown en tik je op het prullenbak/verwijder-pictogram (je moet minimaal twee profielen hebben om er één te kunnen verwijderen).

---

## Technische Details

### Connectiviteit & Ontdekking
De app gebruikt een robuuste meertraps ontdekkingsreeks om je hardware te vinden:
1. **mDNS Resolutie**: De primaire methode. De app scant naar `elrs_rx.local` of `elrs_tx.local`.
2. **Statische AP Fallback**: Als mDNS geblokkeerd is, controleert de app het officiële ELRS toegangspunt IP (`10.0.0.1`).
3. **Handmatige IP Override**: Voor complexe netwerken kun je handmatig een IP-adres invoeren in Instellingen.

**Geforceerde Netwerkbinding**: Moderne smartphones verbreken vaak Wi-Fi-verbindingen zonder internet. ELRS Mobile bevat een native "Forced Routing"-laag die het OS dwingt om vast te houden aan de hardwareverbinding, wat zorgt voor 100% betrouwbare ontdekking in het veld.

---

## Expert Mode & Auditing
Binnen het menu Instellingen kunnen gebruikers de **Expert Mode** inschakelen. Hiermee kun je de geassembleerde firmware binary direct op je apparaat opslaan voor auditing of handmatig flashen via FTDI.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">STM32 Hardware Handling</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Hoewel ELRS Mobile firmware kan assembleren en patchen voor STM32 targets (tot ELRS v3.x), ondersteunen deze apparaten geen Over-The-Air (OTA) flashing via Wi-Fi. Als je een STM32 target selecteert, stelt de app je in staat om de binary lokaal te bouwen en op te slaan, zodat je deze handmatig kunt flashen met een pc via STLink of Betaflight Passthrough.
  </p>
</div>

Voor ontwikkelaars die de integriteit van deze binaries willen verifiëren, zie onze [**Firmware Validatie Gids**](/guides/firmware-validation).

<!-- source_hash: 517ac115b41fa09bfaf858b0da950a2d -->