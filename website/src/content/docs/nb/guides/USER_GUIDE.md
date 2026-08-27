---
title: "Brukerhåndbok"
slug: nb/user_guide
sidebar:
  order: 1
---

```markdown
## Oversikt
Denne applikasjonen tilbyr et omfattende mobilgrensesnitt for administrasjon av ExpressLRS-maskinvare. Den lar brukere konfigurere mottaker (RX) og sender (TX) parametere, tilordne PWM-utganger og flashe firmwareoppdateringer direkte fra en mobil enhet.

---

## Installasjon

### Offisielle App-butikker

#### [Android](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile)
Installer fra Google Play

<a href="https://play.google.com/store/apps/details?id=io.datarx.elrsmobile" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Skaff deg den på Google Play</a>

#### [iOS](https://apps.apple.com/us/app/elrs-mobile/id6760490014)
Installer fra App Store

<a href="https://apps.apple.com/us/app/elrs-mobile/id6760490014" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Last ned i App Store</a>

### Alternativ Installasjon

#### GitHub Store
Ideell for brukere som foretrekker en alternativ app-butikkopplevelse.

<a href="https://github.com/OpenHub-Store/Github-Store" class="inline-block px-8 py-3.5 rounded-xl font-bold text-base transition-all hover:-translate-y-0.5 hover:brightness-110 text-center bg-primary text-background no-underline">Last ned i GitHub Store</a>

### Manuell Installasjon
For avanserte brukere eller de som foretrekker manuell administrasjon, besøk vår [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases)-side for de nyeste `.apk`-filene.

---

## 🚀 Hurtigstart: Flashing av din første enhet

### Fase 1: Mellomlagring av Firmware (Gjør dette hjemme)
1. Åpne appen og naviger til **Firmware Manager**.
2. Trykk på nedlastingsikonet ved siden av den nyeste stabile utgivelsen.
3. Appen vil laste ned og sikkert mellomlagre de nødvendige mål- og maskinvaredesigns for offline bruk.

### Fase 2: Koble til enheten din
1. Slå på din ExpressLRS-mottaker (RX) eller -sender (TX).
2. Vent 60 sekunder (eller ditt konfigurerte intervall) til enheten går inn i Wi-Fi Hotspot-modus (raskt blinkende LED).
3. Koble telefonens Wi-Fi til nettverket **ExpressLRS RX** eller **ExpressLRS TX** (Passord: `expresslrs`).
4. Åpne appen. Dashbordet vil automatisk skanne nettverket ved hjelp av mDNS og koble til enheten.

### Fase 3: Flashing av Firmware
1. Fra dashbordet, velg **Flash Enhet**.
2. **Velg din Maskinvare:** Bruk de kaskaderende nedtrekksmenyene for å velge din Enhetstype, Leverandør, Frekvens og Mål.
3. **Konfigurer Alternativer og Profiler:** Velg en **Flashing Profil** (eller trykk på **+**-knappen for å legge til en ny navngitt profil) for å laste inn dine legitimasjonsdetaljer. Tilpass Binding Phrase, Wi-Fi SSID, Wi-Fi-passord, reguleringsdomener og Wi-Fi auto-på-intervall.
4. Trykk **FLASH**. Appen vil kompilere binærfilen lokalt og sende den til enheten.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Advarsel om Måluoverensstemmelse</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Hvis appen oppdager en maskinvaremål-uoverensstemmelse mellom ditt valg og den tilkoblede enheten, vil den advare deg for å forhindre utilsiktet skade. Hvis du er sikker på at du har riktig mål (f.eks. gjenoppretter fra en dårlig flash eller migrerer mellom mål-definisjoner), klikk <strong>FORCE FLASH</strong> i advarselsdialogen for å omgå sjekken.
  </p>
</div>

### 📋 Administrere Flashing-profiler
Hvis du har flere droner eller radiokonfigurasjoner med forskjellige konfigurasjonskrav (f.eks. forskjellige binding phrases eller reguleringsdomener), kan du bruke navngitte **Flashing-profiler** for å lagre og bytte konfigurasjoner:
* **Legg til en profil**: Trykk på **+**-ikonet ved siden av nedtrekksmenyen "Flashing Profile", skriv inn et navn og trykk Legg til.
* **Automatisk lagring**: Eventuelle endringer i den aktive profilens legitimasjonsdetaljer (binding phrase, SSID, passord, domene eller intervall) lagres automatisk i sanntid.
* **Bytt profiler**: Bare velg en profil fra nedtrekksmenyen for å umiddelbart laste inn de lagrede innstillingene.
* **Slett en profil**: For å rydde opp, velg profilen fra nedtrekksmenyen og trykk på søppelkasse-/sletteikonet (du må ha minst to profiler for å slette en).

---

## Tekniske Detaljer

### Tilkobling og Oppdagelse
Appen bruker en robust flertrinns oppdagelsessekvens for å finne maskinvaren din:
1. **mDNS-oppløsning**: Den primære metoden. Appen skanner etter `elrs_rx.local` eller `elrs_tx.local`.
2. **Statisk AP-tilbakefall**: Hvis mDNS er blokkert, sjekker appen den offisielle ELRS aksesspunkt-IP-en (`10.0.0.1`).
3. **Manuell IP-overstyring**: For komplekse nettverk kan du manuelt angi en IP-adresse i Innstillinger.

**Tvunget Nettverksbinding**: Moderne smarttelefoner kaster ofte bort Wi-Fi-tilkoblinger uten internett. ELRS Mobile inkluderer et innebygd "Tvunget Rutings"-lag som tvinger operativsystemet til å holde seg til maskinvaretilkoblingen, noe som sikrer 100 % pålitelig oppdagelse i felt.


---

## Ekspertmodus og Revisjon
Innenfor Innstillinger-menyen kan brukere aktivere **Ekspertmodus**. Dette lar deg lagre den sammensatte firmware-binærfilen direkte på enheten din for revisjon eller manuell flashing via FTDI.

<div class="p-4 my-8 rounded-2xl border border-primary/20 bg-surface/50 backdrop-blur-md shadow-xl shadow-primary/5">
  <div class="flex items-center gap-3 mb-2">
    <div class="p-2 rounded-lg bg-primary/10 text-primary">
      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" viewBox="0 0 256 256">
        <path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z"></path>
      </svg>
    </div>
    <span class="text-lg font-bold text-primary tracking-tight">Håndtering av STM32 Maskinvare</span>
  </div>
  <p class="text-sm leading-relaxed text-text-muted/90 pl-11">
    Selv om ELRS Mobile kan kompilere og patche firmware for STM32-mål (opp til ELRS v3.x), støtter disse enhetene ikke Over-The-Air (OTA) flashing via Wi-Fi. Hvis du velger et STM32-mål, vil appen la deg bygge og lagre binærfilen lokalt slik at du kan flashe den manuelt ved hjelp av en PC via STLink eller Betaflight Passthrough.
  </p>
</div>

For utviklere som ønsker å verifisere integriteten til disse binærfilene, se vår [**Firmware Valideringsguide**](/guides/firmware-validation).
```

<!-- source_hash: 517ac115b41fa09bfaf858b0da950a2d -->