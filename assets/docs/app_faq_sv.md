# Genomgång

## Fas 1: Cachelagring av Firmware
1. **Anslut till internet:** Se till att din telefon är ansluten till internet (t.ex. hemmets wifi eller mobilnät).
2. **Öppna Firmware Manager:** Navigera till Firmware Manager i appen.
3. **Ladda ner Release:** Tryck på nedladdningsikonen bredvid din önskade ExpressLRS release. Detta cachar säkert de nödvändiga firmware-målen och hårdvarudefinitionerna på din telefon för 100% offline-användning.

## Fas 2: Ansluta till din enhet
1. **Slå på enheten:** Slå på din ExpressLRS Receiver (RX) eller Transmitter (TX).
2. **Vänta på Hotspot:** Vänta tills enheten går in i Wi-Fi Hotspot Mode (indikeras av en snabbt blinkande LED).
3. **Anslut till Hotspot:** Anslut din telefons Wi-Fi till nätverket `ExpressLRS RX` eller `ExpressLRS TX` med lösenordet `expresslrs`.
* **Obs:** ELRS Mobile hanterar inbyggt påtvingad routing, vilket säkerställer att din telefon inte tyst växlar tillbaka till 5G/LTE.

## Fas 3: Flashning av Firmware
1. **Navigera till Flash Device:** Från huvudpanelen, välj **Flash Device**.
2. **Målval:** Använd de nedrullningsbara menyerna för att välja leverantör och specifikt hårdvarumål.
3. **Versionsval:** Välj en tillgänglig firmware-version från ditt offline-förråd.
4. **Konfiguration:** Ange dina anpassade uppgifter. Applikationen sparar WiFi SSID, WiFi Password och Binding Phrase i lokalt lagringsutrymme så att du inte behöver ange dem igen.
5. **Bygg & Flash:** Tryck på **FLASH**. Systemet patchar den binära filen med dina lokala uppgifter och laddar upp den.
* **Viktigt:** Vänta alltid på bekräftelse om lyckad överföring och att enhetens LED återupptar blinkningen innan du kopplar ur!

---

# FAQ

## Behöver jag en internetanslutning eller mobiltjänst för att flasha firmware?
Nej. ELRS Mobile har **100% Offline Flashing**. Så länge du tidigare har laddat ner firmware-versionen via Firmware Manager när du var ansluten till hem-Wi-Fi, kan appen dynamiskt montera och flasha firmware helt offline.

## Jag får ett "Not enough space"-fel när jag flashar min ESP8285-mottagare.
ESP8285-chip (som de som finns på många AIO-kort) har bara 1MB totalt fysiskt lagringsutrymme. Att uppdatera direkt till en större release (som från 3.x till 4.x) över Wi-Fi kan leda till att utrymmet för dubbla partitioner tar slut eftersom den inkommande filen är för stor för att packas upp tillsammans med den för närvarande körande firmwaren.

**Så här åtgärdar du:** Först, flasha din mottagare till en mellanliggande version (som **3.6.3**). När den kör den smidigare 3.6.3-firmwaren, kommer du att ha tillräckligt med partitionsutrymme för att framgångsrikt flasha till ditt önskade 4.0-mål. Alternativt, aktivera **Expert Mode** i Inställningar, spara den byggda binära filen lokalt och flasha den manuellt via en trådbunden Betaflight Passthrough-anslutning.

## Var hittar jag ExpressLRS Lua-skriptet för min radio?
ELRS Mobile levereras med det universella, versionsagnostiska Lua-skriptet inbyggt! För att få det:
1. Gå till **Settings** och växla på **Expert Mode**.
2. Tryck på **Export ELRS Lua Script**.
3. Detta sparar `elrs.lua` direkt till din telefons lokala lagringsutrymme. Slå på din radio och anslut den till din telefon via USB, se till att välja "USB Storage"-läge på din radio och överför filen till din `SCRIPTS/TOOLS`-mapp med din telefons filhanterare.

**Obs:** Du måste radera eventuella tidigare versioner av elrs.lua-skriptet (t.ex. elrs_v2.lua, elrs_v3.lua, etc) från din radios SD-kort innan du använder det nya skriptet.

## Vad händer om en flash misslyckas och min enhet blir orresponsiv?
Om din enhet är orresponsiv efter en misslyckad flash, kan du enkelt återställa den:
1. Håll BOOT-knappen på enheten intryckt medan du ansluter den via USB för att komma in i bootloader-läge.
2. Använd en dator och ELRS Web Flasher för att flasha om enheten via en trådbunden USB/UART-anslutning.
3. För Wi-Fi-kapabla enheter kan du också hålla BOOT

**Obs:** Det finns en videolänk på fliken Resurser som visar hur man gör detta.

## Kan jag spara firmware-filen på min telefon utan att flasha den?
Ja. Genom att gå in i **Settings** och aktivera **Expert Mode** låser du upp möjligheten att spara den sammansatta firmware-binärfilen direkt till din mobila enhets lokala lagringsutrymme istället för att omedelbart flasha den Over-The-Air (OTA).

Detta är särskilt användbart om du vill flasha enheten manuellt med en dedikerad hårdvaruprogrammerare (som en STLink eller FTDI-adapter).

## Jag får ett "Target Mismatch"-fel. Vad ska jag göra?
Ett "target mismatch"-fel uppstår när hårdvarumålet du valde i appen inte matchar målet för den firmware som för närvarande körs på enheten.

För närvarande stöder appen inte att flasha ett annat m��l än det som för närvarande körs på enheten.

<!-- source_hash: 32fdb222bf9c42513cbd49e51679ccaa -->