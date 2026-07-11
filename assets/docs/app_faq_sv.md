# Genomgång

## Fas 1: Cachelagra firmware
1. **Anslut till internet:** Se till att din telefon är ansluten till internet (t.ex. hemmets wifi eller mobilnät).
2. **Öppna Firmware Manager:** Navigera till Firmware Manager i appen.
3. **Ladda ner Release:** Tryck på nedladdningsikonen bredvid din önskade ExpressLRS release. Detta cachelagrar säkert de nödvändiga firmware-målen och hårdvarudefinitionerna på din telefon för 100 % offline-användning.

## Fas 2: Ansluta till din enhet
1. **Slå på enheten:** Slå på din ExpressLRS Receiver (RX) eller Transmitter (TX).
2. **Vänta på Hotspot:** Vänta tills enheten går in i Wi-Fi Hotspot Mode (indikeras av en snabbt blinkande LED).
3. **Anslut till Hotspot:** Anslut telefonens Wi-Fi till nätverket `ExpressLRS RX` eller `ExpressLRS TX` med lösenordet `expresslrs`.
* **Obs:** ELRS Mobile hanterar inbyggt tvingad routing, vilket säkerställer att din telefon inte tyst byter tillbaka till 5G/LTE.

## Fas 3: Flasha firmware
1. **Navigera till Flash Device:** Från huvud-Dashboarden, välj **Flash Device**.
2. **Målval:** Använd de kaskaderande rullgardinsmenyerna för att välja leverantör och specifikt hårdvarumål.
3. **Versionsval:** Välj en tillgänglig firmware-version från ditt offline-arkiv.
4. **Konfiguration & Profiler:** Välj eller skapa en **Flashing Profile** (t.ex. "Mina Quads", "Race Spec") för att ladda dina anpassade referenser. Applikationen sparar Wi-Fi SSID, Wi-Fi Password, Binding Phrase, Regulatory Domain och Auto-On intervaller i dessa namngivna profiler så att du inte behöver ange dem igen när du växlar mellan olika inställningar.
5. **Bygg & Flash:** Tryck på **FLASH**. Systemet patchar binärfilen med dina lokala referenser och laddar upp den.
* **Viktigt:** Vänta alltid på bekräftelsen om lyckad flashning och att enhetens LED återupptar blinkningen innan du kopplar ur!

---

# FAQ

## Behöver jag en internetanslutning eller mobiltjänst för att flasha firmware?
Nej. ELRS Mobile erbjuder **100% Offline Flashing**. Så länge du tidigare har laddat ner firmware-versionen via Firmware Manager när du var ansluten till hemmets Wi-Fi, kan appen dynamiskt sammanställa och flasha firmware helt offline.

## Vad är Flashing Profiles och hur använder jag dem?
Flashing Profiles låter dig spara och växla mellan flera flashningskonfigurationer (t.ex. "Mina Quads", "Stock / Factory Reset", "Race Spec"). Varje profil lagrar säkert sin egen binding phrase, Wi-Fi SSID, Wi-Fi password, regulatoriska domäner och Wi-Fi auto-on intervall.

För att använda dem:
1. Tryck på ikonen **+** (Lägg till) bredvid rullgardinsmenyn "Flashing Profile" i kortet **Configuration Options**.
2. Namnge din nya profil och anpassa inställningarna. Redigeringar sparas automatiskt omedelbart.
3. Välj vilken profil som helst från rullgardinsmenyn för att automatiskt byta alla parametrar.
4. För att radera en profil, välj den och tryck på papperskorgen/radera-ikonen (du måste ha minst två profiler för att radera en).

## Jag får ett "Not enough space"-fel när jag flashar min ESP8285-mottagare.
ESP8285-chipp (som de som finns på många AIO-kort) har bara 1MB totalt fysiskt lagringsutrymme. Att uppdatera direkt till en större release (som från 3.x till 4.x) över Wi-Fi kan leda till att dubbelpartitionsutrymmet tar slut eftersom den inkommande filen är för stor för att packas upp bredvid den nuvarande firmwaren.

**Så här fixar du:** Först, flasha din mottagare till en mellanliggande version (som **3.6.3**). När den kör den mindre 3.6.3-firmwaren, kommer du att ha tillräckligt med partitionsutrymme för att framgångsrikt flasha till ditt önskade 4.0-mål. Alternativt kan du aktivera **Expert Mode** i Inställningar, spara den byggda binärfilen lokalt och flasha den manuellt via en trådbunden Betaflight Passthrough-anslutning.

## Var hittar jag ExpressLRS Lua-skriptet till min radio?
ELRS Mobile levereras med det universella, versions-oberoende Lua-skriptet inbyggt! För att få det:
1. Gå till **Settings** och aktivera **Expert Mode**.
2. Tryck på **Export ELRS Lua Script**.
3. Detta sparar `elrs.lua` direkt till telefonens lokala lagring. Slå på din radio och anslut den till din telefon via USB, se till att välja "USB Storage"-läge på din radio och överför filen till din `SCRIPTS/TOOLS`-mapp med hjälp av telefonens filhanterare.

**Obs:** Du måste radera alla tidigare versioner av elrs.lua-skriptet (t.ex. elrs_v2.lua, elrs_v3.lua, etc) från din radios SD-kort innan du använder det nya skriptet.

## Vad händer om en flashning misslyckas och min enhet blir okänslig?
Om din enhet är okänslig efter en misslyckad flashning kan du enkelt återställa den:
1. Håll BOOT-knappen på enheten medan du ansluter den via USB för att gå in i bootloader-läge.
2. Använd en dator och ELRS Web Flasher för att flasha om enheten via en trådbunden USB/UART-anslutning.
3. För Wi-Fi-kapabla enheter kan du också hålla in BOOT

**Obs:** Det finns en videolänk under fliken Resources som visar hur man gör detta.

## Kan jag spara firmware-filen på min telefon utan att flasha den?
Ja. Genom att gå in i **Settings** och aktivera **Expert Mode** låser du upp möjligheten att spara den sammansatta firmware-binärfilen direkt till din mobila enhets lokala lagring istället för att omedelbart flasha den Over-The-Air (OTA).

Detta är särskilt användbart om du vill flasha enheten manuellt med en dedikerad hårdvaruprogrammerare (som en STLink- eller FTDI-adapter).

## Jag får ett "Target Mismatch"-fel. Vad ska jag göra?
Ett target mismatch-fel uppstår när hårdvarumålet du valde i appen inte matchar målet för den firmware som för närvarande körs på enheten.

För att förhindra oavsiktlig skada kommer appen att varna dig om en mismatch upptäcks. Men om du är säker på att det valda målet är korrekt (till exempel om du konverterar en enhet till en annan firmware-variant eller korrigerar en tidigare felaktig flashning), kan du trycka på **FORCE FLASH** i dialogrutan för mismatch för att åsidosätta kontrollen och fortsätta med flashningen.


<!-- source_hash: 4de4fb02852e8f160449fd60465b7888 -->