# Wandelgids

## Fase 1: Firmware Cachen
1. **Verbind met het internet:** Zorg ervoor dat uw telefoon is verbonden met het internet (bijv. thuis-Wi-Fi of mobiel netwerk).
2. **Open Firmware Manager:** Navigeer naar de Firmware Manager in de app.
3. **Download Release:** Tik op het downloadpictogram naast de gewenste ExpressLRS release. Dit cachet veilig de benodigde firmware-targets en hardwaredefinities op uw telefoon voor 100% offline gebruik.

## Fase 2: Verbinding maken met uw apparaat
1. **Schakel apparaat in:** Schakel uw ExpressLRS Receiver (RX) of Transmitter (TX) in.
2. **Wacht op Hotspot:** Wacht tot het apparaat in Wi-Fi Hotspot Mode gaat (aangegeven door een snel knipperende LED).
3. **Verbind met Hotspot:** Verbind de Wi-Fi van uw telefoon met het `ExpressLRS RX` of `ExpressLRS TX` netwerk met behulp van het wachtwoord `expresslrs`.
* **Opmerking:** ELRS Mobile handelt gedwongen routing van nature af, zodat uw telefoon niet stilletjes terugschakelt naar 5G/LTE.

## Fase 3: Firmware Flashen
1. **Navigeer naar Flash Apparaat:** Selecteer vanaf het hoofddashboard **Flash Apparaat**.
2. **Target Selectie:** Gebruik de trapsgewijze dropdowns om de leverancier en de specifieke hardware-target te selecteren.
3. **Versie Selectie:** Kies een beschikbare firmwareversie uit uw offline repository.
4. **Configuratie & Profielen:** Kies of creëer een **Flashing Profile** (bijv. "My Quads", "Race Spec") om uw aangepaste inloggegevens te laden. De applicatie bewaart de Wi-Fi SSID, Wi-Fi Password, Binding Phrase, Regulatory Domain en Auto-On intervallen in deze benoemde profielen, zodat u ze niet opnieuw hoeft in te voeren bij het wisselen tussen verschillende setups.
5. **Build & Flash:** Tik op **FLASH**. Het systeem patcht het binaire bestand met uw lokale inloggegevens en uploadt het.
* **Cruciaal:** Wacht altijd op de succesbevestiging en totdat de LED van het apparaat weer knippert voordat u de stekker eruit trekt!

---

# Veelgestelde Vragen

## Heb ik een internetverbinding of mobiele service nodig om firmware te flashen?
Nee. ELRS Mobile beschikt over **100% Offline Flashing**. Zolang u de firmwareversie eerder hebt gedownload via de Firmware Manager terwijl u op thuis-Wi-Fi was, kan de app de firmware dynamisch samenstellen en volledig offline flashen.

## Wat zijn Flashing Profiles en hoe gebruik ik ze?
Flashing Profiles stellen u in staat om meerdere flash-configuraties op te slaan en ertussen te wisselen (bijv. "My Quads", "Stock / Factory Reset", "Race Spec"). Elk profiel bewaart veilig zijn eigen binding phrase, Wi-Fi SSID, Wi-Fi password, regulatory domains en Wi-Fi auto-on interval.

Om ze te gebruiken:
1. Tik op het **+** (Toevoegen) pictogram naast de "Flashing Profile" dropdown in de kaart **Configuration Options**.
2. Geef uw nieuwe profiel een naam en pas de instellingen aan. Wijzigingen worden direct automatisch opgeslagen.
3. Selecteer een profiel uit de dropdown om alle parameters automatisch te wisselen.
4. Om een profiel te verwijderen, selecteer het en tik op het prullenbak-/verwijderpictogram (u moet ten minste twee profielen hebben om er één te kunnen verwijderen).

## Ik krijg een "Not enough space" foutmelding bij het flashen van mijn ESP8285 ontvanger.
ESP8285 chips (zoals die te vinden zijn op veel AIO-boards) hebben slechts 1MB totale fysieke opslag. Rechtstreeks updaten naar een belangrijke release (zoals van 3.x naar 4.x) via Wi-Fi kan leiden tot een tekort aan dual-partition ruimte omdat het inkomende bestand te groot is om naast de momenteel draaiende firmware uit te pakken.

**Hoe op te lossen:** Flash eerst uw ontvanger naar een tussenversie (zoals **3.6.3**). Zodra deze de slankere 3.6.3 firmware draait, heeft u voldoende partitieruimte om succesvol naar uw gewenste 4.0 target te flashen. Als alternatief, schakel **Expert Mode** in Instellingen in, sla het gebouwde binaire bestand lokaal op, en flash het handmatig via een bekabelde Betaflight Passthrough verbinding.

## Waar vind ik het ExpressLRS Lua script voor mijn zender?
ELRS Mobile wordt geleverd met het universele, versie-onafhankelijke Lua script ingebouwd! Om het te verkrijgen:
1. Ga naar **Instellingen** en schakel **Expert Mode** in.
2. Tik op **Export ELRS Lua Script**.
3. Dit slaat `elrs.lua` rechtstreeks op in de lokale opslag van uw telefoon. Schakel uw zender in en sluit deze via USB aan op uw telefoon, zorg ervoor dat u de "USB Storage" modus op uw zender selecteert en breng het bestand over naar uw `SCRIPTS/TOOLS` map met behulp van de bestandsbeheerder van uw telefoon.

**Opmerking:** U moet alle eerdere versies van het elrs.lua script (bijv. elrs_v2.lua, elrs_v3.lua, enz.) van de SD-kaart van uw zender verwijderen voordat u het nieuwe script gebruikt.

## Wat als een flash mislukt en mijn apparaat niet meer reageert?
Als uw apparaat niet meer reageert na een mislukte flash, kunt u het eenvoudig herstellen:
1. Houd de BOOT-knop op het apparaat ingedrukt terwijl u het via USB aansluit om de bootloader-modus te activeren.
2. Gebruik een computer en de ELRS Web Flasher om het apparaat opnieuw te flashen via een bekabelde USB/UART verbinding.
3. Voor Wi-Fi-geschikte apparaten kunt u ook de BOOT

**Opmerking:** Er is een videolink op het tabblad Resources die laat zien hoe u dit doet.

## Kan ik het firmwarebestand op mijn telefoon opslaan zonder het te flashen?
Ja. Door naar **Instellingen** te gaan en **Expert Mode** in te schakelen, ontgrendelt u de mogelijkheid om het geassembleerde firmware-binaire bestand rechtstreeks op de lokale opslag van uw mobiele apparaat op te slaan in plaats van het onmiddellijk Over-The-Air (OTA) te flashen.

Dit is vooral handig als u het apparaat handmatig wilt flashen met behulp van een speciale hardwareprogrammeur (zoals een STLink of FTDI adapter).

## Ik krijg een "Target Mismatch" foutmelding. Wat moet ik doen?
Een target mismatch fout treedt op wanneer de hardware-target die u in de app hebt geselecteerd niet overeenkomt met de target van de firmware die momenteel op het apparaat draait.

Om accidentele schade te voorkomen, waarschuwt de app u als een mismatch wordt gedetecteerd. Als u er echter zeker van bent dat de geselecteerde target correct is (bijvoorbeeld als u een apparaat converteert naar een andere firmwarevariant of een eerdere onjuiste flash corrigeert), kunt u op **FORCE FLASH** tikken in het mismatch-dialoogvenster om de controle te omzeilen en door te gaan met de flash.

<!-- source_hash: 4de4fb02852e8f160449fd60465b7888 -->