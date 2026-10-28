---
title: "Brukerveiledning"
slug: nb/user_guide
sidebar:
  order: 1
---

ELRS Mobile flasher og konfigurerer ExpressLRS-mottakere (RX) og sendere (TX) fra telefonen din, over Wi-Fi, uten behov for bærbar PC eller internettforbindelse ute i felten. Den fungerer med ESP-basert maskinvare (ESP8285, ESP32, ESP32-C3, ESP32-S3) og ExpressLRS 3.3.x og 4.x fastvare. Se [Støttet maskinvare](/supported_hardware) for hver kompatible enhet.

Arbeidsflyten har to deler: last ned fastvare mens du har internett, og flash den deretter hvor som helst.

---

## Installasjon

| Plattform | Hvor du får den |
| :--- | :--- |
| Android | [Google Play](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile) |
| iPhone og iPad | [App Store](https://apps.apple.com/us/app/elrs-mobile/id6760490014) |
| Android, uten Google Play | [Direkte APK-nedlasting](https://cdn.elrsmobile.com/ELRS-Mobile-latest.apk), [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases), eller [GitHub Store](https://github.com/OpenHub-Store/Github-Store) |

Butikkversjonene oppdateres via Google Play og App Store. Den direkte nedlastbare APK-en sjekker for en ny utgivelse én gang om dagen og tilbyr å laste den ned; du kan også sjekke når som helst fra **Innstillinger → Om og Juridisk → Se etter oppdateringer**, hoppe over en versjon, eller bli påminnet senere. Innstillingene og profilene dine beholdes når du installerer en oppdatering.

Vil du ha nye funksjoner tidlig? Bli med i [Google Play beta](https://play.google.com/apps/testing/io.datarx.elrsmobile) eller [TestFlight beta](https://testflight.apple.com/join/jwU1WrpX).

Ved første oppstart viser appen en kort ansvarsfraskrivelse. Flashing av fastvare innebærer alltid en viss risiko for maskinvaren din; godta for å fortsette.

---

## Hurtigstart: flashing av din første enhet

### Trinn 1: Last ned fastvare (hjemme)

1. På Dashboard, åpne **Firmware Manager**.
2. Trykk på nedlastingsikonet ved siden av ExpressLRS-versjonen du ønsker. Kun versjoner 3.3.0 og nyere er oppført: de er de første med den enhetlige fastvaren som ELRS Mobile bygger på.
3. Når nedlastingen er ferdig, viser versjonen **Klar for offline bruk**. Fastvaren og maskinvaredefinisjonene den trenger er nå lagret på telefonen din.

Last ned fastvare over ditt hjemme-Wi-Fi eller mobildata. Du kan ikke laste ned mens telefonen din er koblet til en mottakers eller senders Wi-Fi-hotspot, fordi det nettverket ikke har internett.

Toppteksten viser hvor mange versjoner du har lagret mot grensen din. Endre grensen i **Innstillinger → App og Lagring → Maks hurtigbufrede versjoner**, og slett versjoner du ikke lenger trenger.

### Trinn 2: Koble til enheten din

1. Slå på mottakeren eller senderen din og vent til den starter sin Wi-Fi-hotspot. Som standard skjer dette 60 sekunder etter oppstart hvis den ikke har koblet seg til partneren sin. Sendere kan også starte Wi-Fi fra ExpressLRS Lua-skriptet på radioen din.
2. På telefonen din, koble til nettverket **ExpressLRS RX** eller **ExpressLRS TX**. Passordet er `expresslrs`.
3. Åpne ELRS Mobile. Dashboard finner enheten automatisk og viser produktnavnet, fastvareversjonen, target og reguleringsdomenet.

Hvis Dashboard viser **Ingen enhet funnet**, trykk **Prøv på nytt**. Hvis enheten din er på et annet nettverk (for eksempel tilkoblet ditt hjemme-Wi-Fi), trykk på tannhjulikonet på enhetskortet og skriv inn IP-adressen.

Enheter som kjører fastvare eldre enn 3.1 blir også oppdaget, slik at du kan oppdatere dem til en nyere versjon.

### Trinn 3: Flash

1. På Dashboard, trykk **Flash enhet**.
2. Sjekk target. Appen forhåndsvelger target som samsvarer med den tilkoblede enheten når den kan; ellers velg Enhetstype, Enhetsleverandør, Regulering og Frekvens, og Enhetstarget.
3. Velg fastvareversjonen. Versjoner du har lastet ned er merket **(Mellomlagret)**. Hvis maskinvaren trenger en nyere versjon enn du har, sier appen ifra og tilbyr å laste ned en kompatibel.
4. Sjekk fastvarealternativene: flashing-profil, binding phrase, Wi-Fi-nettverk og passord, reguleringsdomene, og Wi-Fi auto-på-intervall.
5. Trykk **Flash**.

Fremdriftslinjen følger hvert trinn: lokalisering og utpakking av den nedlastede fastvaren, bygging med dine innstillinger, opplasting, og **Skriver til enhet – Vennligst vent** mens enheten installerer den og starter på nytt. Når enheten bekrefter, vil du se **Flashing vellykket! Enheten starter på nytt**, og Dashboard kobler seg til igjen når den er tilbake.

---

## Sikkerhetskontroller

Appen sjekker valgene dine før flashing og stopper hvis noe ser feil ut.

:::danger[Inkompatibel chip]
Fastvare for én chip kan aldri kjøre på en annen (for eksempel ESP32-fastvare på en ESP8285-mottaker). Appen blokkerer flashingen og forteller deg hvilken chip hver enkelt er. Velg et target for enhetens chip.
:::

:::caution[Target-inkonsekvens]
Hvis det valgte target ikke samsvarer med produktet enheten rapporterer, vil du se **Target-inkonsekvens**. Sjekk valget ditt først. Hvis du er sikker på at det er riktig (for eksempel gjenoppretting etter en dårlig flash eller flytting til en nyere target-definisjon), trykk **Tving Flash**.
:::

:::note[Ingen binding phrase]
Flashing uten en binding phrase fungerer, men enheten vil bare binde ved hjelp av standard (tom) phrase. Appen spør før du fortsetter.
:::

:::caution[Flash ikke bekreftet]
Hvis enheten kobler fra før flashingen er bekreftet (den mistet strøm, startet på nytt, eller Wi-Fi-forbindelsen falt ut), kan appen ikke vite om oppdateringen ble fullført. Den viser en gul advarsel i stedet for å rapportere suksess. Koble til igjen og sjekk fastvareversjonen på Dashboard; hvis den ikke har endret seg, flash på nytt.
:::

---

## Flashing-profiler

En flashing-profil lagrer en binding phrase, hjemme-Wi-Fi-nettverk og passord, standard reguleringsdomener, og Wi-Fi auto-på-intervall under et navn. Bruk én per flåte eller radiooppsett, og bytt mellom dem med ett trykk.

Administrer profiler i **Innstillinger → Profiler og Nettverk**:

- **Legg til:** trykk **+**, skriv et navn, og trykk **Legg til**.
- **Bytt:** velg en profil fra listen **Flashing-profil**. Den er også tilgjengelig på flashing-skjermen.
- **Rediger:** endre et hvilket som helst felt; den aktive profilen lagres automatisk.
- **Slett:** velg profilen og trykk på sletteikonet. Du beholder alltid minst én profil.

Binding phrases og Wi-Fi-passord lagres i telefonens krypterte sikre lagring.

---

## Enhetskonfigurasjon

På Dashboard, trykk **Enhetskonfigurasjon** for å åpne den tilkoblede enhetens egen ExpressLRS-innstillingsside inne i appen. Bruk den til å endre Wi-Fi- og binding-innstillinger, modellmatching, seriell protokoll, PWM-utgangstilordning og andre enhetsalternativer. Appen holder siden låst til din enhet.

---

## Innstillinger

| Seksjon | Hva du finner der |
| :--- | :--- |
| Profiler og Nettverk | Flashing-profiler, binding phrase, hjemme-Wi-Fi-nettverk og passord, standard 2.4 GHz og sub-GHz reguleringsdomener |
| App og Lagring | Maks hurtigbufrede versjoner, Firmware Manager, tøm fastvarebufferen, app-språk, anonym bruksanalyse (på som standard; slå av med **Del analyse**) |
| Avansert og Feilsøking | Expert Mode og verktøyene (nedenfor) |
| Om og Juridisk | Appversjon, juridisk merknad og lisens, støtt utvikling, og **Se etter oppdateringer** i den direkte nedlastede APK-en |

Endre app-språket fra Innstillinger eller språkknappen i topplinjen. ELRS Mobile er tilgjengelig på 18 språk.

---

## Expert Mode

Slå på **Innstillinger → Avansert og Feilsøking → Expert Mode** for å låse opp:

- **STM32 targets.** Eldre STM32-basert maskinvare kan ikke flashes over Wi-Fi, og kun ExpressLRS 3.3.x støtter det. Appen bygger fastvaren med innstillingene dine slik at du kan flashe den fra en PC med en STLink eller Betaflight passthrough.
- **Last ned binærfil.** Lagre den bygde fastvarefilen i stedet for å flashe den, for manuell flashing eller revisjon.
- **Eksporter ELRS Lua Script.** Lagre `elrs.lua` for EdgeTX- og OpenTX-radioer.
- **Send feilrapport.** Send enhetsinformasjon og applogger for å hjelpe med å fikse en feil. Binding phrases og Wi-Fi-passord er aldri inkludert.

---

## Feilsøking

**Dashboard finner ikke enheten min.** Sørg for at telefonen din fortsatt er koblet til enhetens Wi-Fi-nettverk; noen telefoner forlater nettverk som ikke har internett. På Android beholder ELRS Mobile sin trafikk på det Wi-Fi-nettverket selv uten internett. Trykk **Prøv på nytt**, eller skriv inn IP-adressen fra tannhjulikonet (`10.0.0.1` på enhetens egen hotspot).

**Jeg kan ikke laste ned fastvare.** Koble fra enhetens hotspot og bruk et nettverk med internett.

**Enheten min er uten respons etter en mislykket flash.** Hold BOOT-knappen inne mens du kobler den til via USB for å gå inn i bootloader-modus, og flash deretter på nytt med [ExpressLRS Web Flasher](https://expresslrs.org/flasher). Wi-Fi-kompatible enheter kan også gjenopprettes ved å holde BOOT inne i 60 sekunder for å starte Wi-Fi-hotspoten. Skjermen **Hjelp og støtte** i appen har disse trinnene, en FAQ, og lenker til ExpressLRS Discord.

**Profilene mine forsvant etter oppdatering.** Oppdatering direkte fra v1.0.43 eller eldre til v1.0.45 eller nyere kan ikke overføre lagrede profiler, binding phrases og Wi-Fi-innstillinger over en lagringsoppgradering. Appen informerer deg én gang; skriv dem inn på nytt i Innstillinger.

---

Utviklere kan verifisere fastvaren ELRS Mobile bygger med [Verktøy for fastvarevalidering](/firmware-validation).

<!-- source_hash: 927017dfd36d96b7c787e4972528233d -->