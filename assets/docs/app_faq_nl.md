# Stappenplan

## Fase 1: Firmware Cachen
1.  **Verbind met het internet:** Zorg ervoor dat uw telefoon verbonden is met het internet (bijv. thuis wifi of mobiel netwerk).
2.  **Open Firmware Manager:** Navigeer naar de Firmware Manager in de app.
3.  **Download Release:** Tik op het downloadpictogram naast de gewenste ExpressLRS release. Dit cachet veilig de benodigde firmware targets en hardwaredefinities op uw telefoon voor 100% offline gebruik.

## Fase 2: Verbinding maken met uw apparaat
1.  **Schakel apparaat in:** Schakel uw ExpressLRS Receiver (RX) of Transmitter (TX) in.
2.  **Wacht op Hotspot:** Wacht tot het apparaat in Wi-Fi Hotspot Modus komt (aangegeven door een snel knipperende LED).
3.  **Verbind met Hotspot:** Verbind de Wi-Fi van uw telefoon met het `ExpressLRS RX` of `ExpressLRS TX` netwerk met behulp van het wachtwoord `expresslrs`.
*   **Opmerking:** ELRS Mobile verwerkt native geforceerde routing, waardoor uw telefoon niet stilletjes terugschakelt naar 5G/LTE.

## Fase 3: Firmware Flashen
1.  **Navigeer naar Flash Device:** Selecteer vanuit het hoofddashboard **Flash Device**.
2.  **Target Selectie:** Gebruik de trapsgewijze dropdownmenu's om de vendor en het specifieke hardware target te selecteren.
3.  **Versie Selectie:** Kies een beschikbare firmwareversie uit uw offline repository.
4.  **Configuratie:** Voer uw aangepaste inloggegevens in. De applicatie bewaart de WiFi SSID, WiFi Password en Binding Phrase in lokale opslag, zodat u deze niet opnieuw hoeft in te voeren.
5.  **Build & Flash:** Tik op **FLASH**. Het systeem patcht het binaire bestand met uw lokale inloggegevens en uploadt het.
*   **Cruciaal:** Wacht altijd op de succesbevestiging en tot de LED van het apparaat weer knippert voordat u de stekker uit het stopcontact haalt!

---

# Veelgestelde Vragen

## Heb ik een internetverbinding of mobiele service nodig om firmware te flashen?
Nee. ELRS Mobile biedt **100% Offline Flashing**. Zolang u de firmwareversie eerder hebt gedownload via de Firmware Manager terwijl u verbonden was met thuis Wi-Fi, kan de app de firmware volledig offline dynamisch assembleren en flashen.

## Ik krijg een "Onvoldoende ruimte" foutmelding bij het flashen van mijn ESP8285 ontvanger.
ESP8285 chips (zoals die op veel AIO-boards te vinden zijn) hebben slechts 1MB totale fysieke opslagruimte. Direct updaten naar een major release (zoals van 3.x naar 4.x) via Wi-Fi kan leiden tot een tekort aan dual-partition ruimte omdat het inkomende bestand te groot is om naast de momenteel draaiende firmware uit te pakken.

**Oplossing:** Flash eerst uw ontvanger naar een tussenliggende versie (zoals **3.6.3**). Zodra deze de slankere 3.6.3 firmware draait, heeft u voldoende partitieruimte om succesvol naar uw gewenste 4.0 target te flashen. Als alternatief, schakel **Expert Mode** in onder Instellingen, sla de gebouwde binary lokaal op en flash deze handmatig via een bekabelde Betaflight Passthrough verbinding.

## Waar vind ik het ExpressLRS Lua script voor mijn radio?
ELRS Mobile wordt geleverd met het universele, versie-onafhankelijke Lua script ingebouwd! Om het te verkrijgen:
1.  Ga naar **Instellingen** en schakel **Expert Mode** in.
2.  Tik op **Export ELRS Lua Script**.
3.  Dit slaat `elrs.lua` direct op in de lokale opslag van uw telefoon. Schakel uw radio in en sluit deze via USB aan op uw telefoon, zorg ervoor dat u de "USB Storage" modus op uw radio selecteert en breng het bestand over naar uw `SCRIPTS/TOOLS` map met behulp van de bestandsbeheerder van uw telefoon.

**Opmerking:** U moet alle eerdere versies van het elrs.lua script (bijv. elrs_v2.lua, elrs_v3.lua, enz.) van de SD-kaart van uw radio verwijderen voordat u het nieuwe script gebruikt.

## Wat als een flash mislukt en mijn apparaat niet meer reageert?
Als uw apparaat niet meer reageert na een mislukte flash, kunt u het eenvoudig herstellen:
1.  Houd de BOOT-knop op het apparaat ingedrukt terwijl u het via USB aansluit om de bootloader-modus te openen.
2.  Gebruik een computer en de ELRS Web Flasher om het apparaat opnieuw te flashen via een bekabelde USB/UART verbinding.
3.  Voor Wi-Fi-compatibele apparaten kunt u ook de BOOT-knop ingedrukt houden.

**Opmerking:** Er is een videolink op het tabblad Resources die laat zien hoe u dit doet.

## Kan ik het firmwarebestand opslaan op mijn telefoon zonder het te flashen?
Ja. Door naar **Instellingen** te gaan en **Expert Mode** in te schakelen, ontgrendelt u de mogelijkheid om het geassembleerde firmware binaire bestand direct op de lokale opslag van uw mobiele apparaat op te slaan, in plaats van het onmiddellijk Over-The-Air (OTA) te flashen.

Dit is vooral handig als u het apparaat handmatig wilt flashen met een speciale hardwareprogrammeur (zoals een STLink of FTDI-adapter).

## Ik krijg een "Target Mismatch" foutmelding. Wat moet ik doen?
Een target mismatch fout treedt op wanneer het hardware target dat u in de app hebt geselecteerd niet overeenkomt met het target van de firmware die momenteel op het apparaat draait.

Momenteel ondersteunt de app het flashen van een ander target dan het target dat momenteel op het apparaat draait niet.

<!-- source_hash: 32fdb222bf9c42513cbd49e51679ccaa -->