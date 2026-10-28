---
title: "Gebruikershandleiding"
slug: nl/user_guide
sidebar:
  order: 1
---

ELRS Mobile flasht en configureert ExpressLRS ontvangers (RX) en zenders (TX) vanaf je telefoon, via Wi-Fi, zonder laptop en zonder internetverbinding in het veld. Het werkt met ESP-gebaseerde hardware (ESP8285, ESP32, ESP32-C3, ESP32-S3) en ExpressLRS 3.3.x en 4.x firmware. Zie [Ondersteunde Hardware](/supported_hardware) voor elk compatibel apparaat.

De workflow bestaat uit twee delen: download firmware terwijl je internet hebt, en flash vervolgens overal.

---

## Installatie

| Platform | Waar te verkrijgen |
| :--- | :--- |
| Android | [Google Play](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile) |
| iPhone en iPad | [App Store](https://apps.apple.com/us/app/elrs-mobile/id6760490014) |
| Android, zonder Google Play | [Directe APK download](https://cdn.elrsmobile.com/ELRS-Mobile-latest.apk), [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases), of [GitHub Store](https://github.com/OpenHub-Store/Github-Store) |

De winkelversies worden geüpdatet via Google Play en de App Store. De direct-download APK controleert één keer per dag op een nieuwe release en biedt deze aan om te downloaden; je kunt ook op elk moment controleren via **Instellingen → Over & Juridisch → Controleren op updates**, een versie overslaan of later herinnerd worden. Je instellingen en profielen blijven behouden wanneer je een update installeert.

Wil je nieuwe functies eerder? Meld je aan voor de [Google Play beta](https://play.google.com/apps/testing/io.datarx.elrsmobile) of de [TestFlight beta](https://testflight.apple.com/join/jwU1WrpX).

Bij de eerste lancering toont de app een korte disclaimer. Firmware flashen brengt altijd enig risico met zich mee voor je hardware; accepteer dit om door te gaan.

---

## Snelstart: je eerste apparaat flashen

### Stap 1: Firmware downloaden (thuis)

1. Open op het Dashboard de **Firmware Manager**.
2. Tik op het downloadicoon naast de gewenste ExpressLRS-versie. Alleen versies 3.3.0 en nieuwer worden vermeld: dit zijn de eersten met de uniforme firmware waarop ELRS Mobile voortbouwt.
3. Wanneer de download is voltooid, toont de versie **Klaar voor offline gebruik**. De firmware en de benodigde hardwaredeprofielen zijn nu op je telefoon opgeslagen.

Download firmware via je thuis-Wi-Fi of mobiele data. Je kunt niet downloaden terwijl je telefoon is verbonden met de Wi-Fi hotspot van een ontvanger of zender, omdat dat netwerk geen internet heeft.

De kop toont hoeveel versies je hebt opgeslagen ten opzichte van je limiet. Wijzig de limiet in **Instellingen → App & Opslag → Max. in cache opgeslagen versies**, en verwijder versies die je niet langer nodig hebt.

### Stap 2: Verbinden met je apparaat

1. Schakel je ontvanger of zender in en wacht tot deze zijn Wi-Fi hotspot start. Standaard gebeurt dit 60 seconden na het inschakelen als deze nog geen verbinding heeft gemaakt met zijn partner. Zenders kunnen ook Wi-Fi starten vanuit het ExpressLRS Lua-script op je radio.
2. Verbind op je telefoon met het **ExpressLRS RX**- of **ExpressLRS TX**-netwerk. Het wachtwoord is `expresslrs`.
3. Open ELRS Mobile. Het Dashboard vindt het apparaat automatisch en toont de productnaam, firmwareversie, target en het regelgevend domein.

Als het Dashboard **Geen apparaat gevonden** toont, tik dan op **Opnieuw proberen**. Als je apparaat op een ander netwerk zit (bijvoorbeeld verbonden met je thuis-Wi-Fi), tik dan op het tandwielicoon op de apparaatkaart en voer het IP-adres in.

Apparaten met firmware ouder dan 3.1 worden ook gedetecteerd, zodat je ze kunt updaten naar een huidige release.

### Stap 3: Flashen

1. Tik op het Dashboard op **Flash apparaat**.
2. Controleer de target. De app selecteert de target die overeenkomt met het verbonden apparaat wanneer mogelijk; anders kies je Apparaattype, Apparaatleverancier, Regelgeving & Frequentie, en Apparaat Target.
3. Kies de firmwareversie. Versies die je hebt gedownload zijn gemarkeerd als **(In cache)**. Als de hardware een nieuwere versie nodig heeft dan je hebt, geeft de app dit aan en biedt aan een compatibele versie te downloaden.
4. Controleer de firmware-opties: flashing profiel, binding phrase, Wi-Fi-netwerk en wachtwoord, regelgevend domein en Wi-Fi automatisch-aan interval.
5. Tik op **Flash**.

De voortgangsbalk volgt elke stap: het lokaliseren en uitpakken van je gedownloade firmware, het bouwen ervan met je instellingen, het uploaden ervan, en **Naar apparaat schrijven — Even geduld a.u.b.** terwijl het apparaat het installeert en opnieuw opstart. Wanneer het apparaat bevestigt, zie je **Flashen succesvol! Apparaat wordt opnieuw opgestart**, en het Dashboard maakt opnieuw verbinding zodra het weer actief is.

---

## Veiligheidscontroles

De app controleert je keuzes voordat het flashen begint en stopt als er iets mis lijkt te zijn.

:::danger[Incompatibele chip]
Firmware voor de ene chip kan nooit draaien op een andere (bijvoorbeeld ESP32 firmware op een ESP8285 ontvanger). De app blokkeert de flash en vertelt je welke chip elk is. Kies een target voor de chip van je apparaat.
:::

:::caution[Target komt niet overeen]
Als de geselecteerde target niet overeenkomt met het product dat het apparaat rapporteert, zie je **Target komt niet overeen**. Controleer eerst je selectie. Als je zeker weet dat het correct is (bijvoorbeeld herstellen van een mislukte flash of overstappen naar een nieuwere targetdefinitie), tik dan op **Forceer Flash**.
:::

:::note[Geen binding phrase]
Flashen zonder een binding phrase werkt, maar het apparaat zal alleen binden met de standaard (lege) phrase. De app vraagt om bevestiging voordat je doorgaat.
:::

:::caution[Flash niet bevestigd]
Als het apparaat de verbinding verbreekt voordat de flash wordt bevestigd (stroomuitval, opnieuw opgestart, of de Wi-Fi-verbinding viel weg), kan de app niet vaststellen of de update is voltooid. Het toont een oranje waarschuwing in plaats van succes te melden. Maak opnieuw verbinding en controleer de firmwareversie op het Dashboard; als deze niet is gewijzigd, flash dan opnieuw.
:::

---

## Flashing profielen

Een flashing profiel slaat een binding phrase, thuis Wi-Fi-netwerk en wachtwoord, standaard regelgevende domeinen en Wi-Fi automatisch-aan interval op onder een naam. Gebruik er één per vloot of radio-setup, en schakel ertussen met één tik.

Beheer profielen in **Instellingen → Profielen & Netwerk**:

- **Toevoegen:** tik op **+**, typ een naam en tik op **Toevoegen**.
- **Wisselen:** kies een profiel uit de lijst **Flashing Profiel**. Het is ook beschikbaar op het flashing scherm.
- **Bewerken:** wijzig een veld; het actieve profiel wordt automatisch opgeslagen.
- **Verwijderen:** selecteer het profiel en tik op het verwijdericoon. Je behoudt altijd minstens één profiel.

Binding phrases en Wi-Fi-wachtwoorden worden opgeslagen in de versleutelde veilige opslag van je telefoon.

---

## Apparaatconfiguratie

Tik op het Dashboard op **Apparaatconfiguratie** om de eigen ExpressLRS instellingenpagina van het verbonden apparaat binnen de app te openen. Gebruik dit om Wi-Fi- en bindinginstellingen, model match, seriële protocol, PWM-uitgangstoewijzing en andere apparaatopties te wijzigen. De app houdt de pagina vergrendeld aan je apparaat.

---

## Instellingen

| Sectie | Wat is er te vinden |
| :--- | :--- |
| Profielen & Netwerk | Flashing profielen, binding phrase, thuis Wi-Fi-netwerk en wachtwoord, standaard 2.4 GHz en sub-GHz regelgevende domeinen |
| App & Opslag | Max. in cache opgeslagen versies, Firmware Manager, firmware-cache wissen, app-taal, anonieme gebruiksstatistieken (standaard aan; uitschakelen met **Deel Analytics**) |
| Geavanceerd & Debug | Expertmodus en de bijbehorende tools (zie hieronder) |
| Over & Juridisch | App-versie, juridische mededeling en licentie, ondersteun ontwikkeling, en **Controleren op updates** in de direct-download APK |

Wijzig de app-taal via Instellingen of de taal-knop in de bovenste balk. ELRS Mobile is beschikbaar in 18 talen.

---

## Expertmodus

Schakel **Instellingen → Geavanceerd & Debug → Expertmodus** in om het volgende te ontgrendelen:

- **STM32 targets.** Oudere STM32-gebaseerde hardware kan niet via Wi-Fi worden geflasht, en alleen ExpressLRS 3.3.x ondersteunt dit. De app bouwt de firmware met je instellingen zodat je deze vanaf een pc kunt flashen met een STLink of Betaflight passthrough.
- **Download Binary.** Sla het gebouwde firmwarebestand op in plaats van het te flashen, voor handmatig flashen of controleren.
- **Exporteer ELRS Lua Script.** Sla `elrs.lua` op voor EdgeTX- en OpenTX-radio's.
- **Dien Debug Rapport in.** Stuur apparaatinformatie en app-logs om een bug te helpen oplossen. Binding phrases en Wi-Fi-wachtwoorden zijn nooit inbegrepen.

---

## Probleemoplossing

**Het Dashboard kan mijn apparaat niet vinden.** Zorg ervoor dat je telefoon nog steeds is verbonden met het Wi-Fi-netwerk van het apparaat; sommige telefoons verlaten netwerken die geen internet hebben. Op Android houdt ELRS Mobile zijn verkeer op dat Wi-Fi-netwerk, zelfs zonder internet. Tik op **Opnieuw proberen**, of voer het IP-adres in via het tandwielicoon (`10.0.0.1` op de eigen hotspot van het apparaat).

**Ik kan geen firmware downloaden.** Verbreek de verbinding met de hotspot van het apparaat en gebruik een netwerk met internet.

**Mijn apparaat reageert niet na een mislukte flash.** Houd de BOOT-knop ingedrukt terwijl je deze via USB aansluit om de bootloader-modus te openen, en flash vervolgens opnieuw met de [ExpressLRS Web Flasher](https://expresslrs.org/flasher). Wi-Fi-geschikte apparaten kunnen ook worden hersteld door de BOOT-knop 60 seconden ingedrukt te houden om de Wi-Fi hotspot te starten. Het in-app **Hulp & Ondersteuning**-scherm bevat deze stappen, een FAQ en links naar de ExpressLRS Discord.

**Mijn profielen zijn verdwenen na een update.** Rechtstreeks updaten van v1.0.43 of ouder naar v1.0.45 of nieuwer kan opgeslagen profielen, binding phrases en Wi-Fi-instellingen niet meenemen bij een opslagupgrade. De app informeert je één keer; voer ze opnieuw in bij Instellingen.

---

Ontwikkelaars kunnen de firmware die ELRS Mobile bouwt verifiëren met de [Firmware Validatie Tools](/firmware-validation).

<!-- source_hash: 927017dfd36d96b7c787e4972528233d -->