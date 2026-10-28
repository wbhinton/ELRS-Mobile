# Návod

## Fáze 1: Ukládání firmware do mezipaměti
1. **Připojte se k internetu:** Ujistěte se, že je váš telefon připojen k internetu (např. domácí Wi-Fi nebo mobilní síť).
2. **Otevřete Správce firmware:** V aplikaci přejděte do Správce firmware.
3. **Stáhněte vydání:** Klepněte na ikonu stahování vedle požadovaného vydání ExpressLRS. Tím se bezpečně uloží potřebné cíle firmware a definice hardwaru do mezipaměti vašeho telefonu pro 100% offline použití.

## Fáze 2: Připojení k vašemu zařízení
1. **Zapněte zařízení:** Zapněte váš ExpressLRS Receiver (RX) nebo Transmitter (TX).
2. **Počkejte na Hotspot:** Počkejte, až zařízení přejde do Wi-Fi Hotspot Mode (indikováno rychlým blikáním LED).
3. **Připojte se k Hotspotu:** Připojte Wi-Fi vašeho telefonu k síti `ExpressLRS RX` nebo `ExpressLRS TX` pomocí hesla `expresslrs`.
* **Poznámka:** ELRS Mobile nativně řeší vynucené směrování a zajišťuje, že se váš telefon tiše nepřepne zpět na 5G/LTE.

## Fáze 3: Nahrávání firmware
1. **Přejděte na Flash Device:** Z hlavního Dashboardu vyberte **Flash Device**.
2. **Výběr cíle:** Pomocí kaskádových rozbalovacích nabídek vyberte dodavatele a konkrétní hardwarový cíl.
3. **Výběr verze:** Vyberte dostupnou verzi firmware z vašeho offline úložiště.
4. **Konfigurace a profily:** Vyberte nebo vytvořte **Flashing Profile** (např. „My Quads“, „Race Spec“) pro načtení vašich vlastních přihlašovacích údajů. Aplikace uchovává Wi-Fi SSID, Wi-Fi Password, Binding Phrase, Regulatory Domain a Auto-On intervals v těchto pojmenovaných profilech, takže je nemusíte znovu zadávat při přepínání mezi různými nastaveními.
5. **Sestavení a nahrání:** Klepněte na **FLASH**. Systém patchuje binární soubor s vašimi místními údaji a nahraje jej.
* **Klíčové:** Vždy počkejte na potvrzení úspěšného dokončení a na to, až se LED dioda zařízení znovu rozbliká, než jej odpojíte!

---

# Často kladené otázky

## Potřebuji připojení k internetu nebo mobilní službu k nahrání firmware?
Ne. ELRS Mobile nabízí **100% Offline Flashing**. Dokud jste dříve stáhli verzi firmware pomocí Firmware Manageru, když jste byli na domácí Wi-Fi, aplikace může dynamicky sestavit a nahrát firmware zcela offline.

## Co jsou Flashing Profiles a jak je používat?
Flashing Profiles vám umožňují ukládat a přepínat mezi více konfiguracemi nahrávání (např. „My Quads“, „Stock / Factory Reset“, „Race Spec“). Každý profil bezpečně ukládá vlastní binding phrase, Wi-Fi SSID, Wi-Fi password, regulatory domains a Wi-Fi auto-on interval.

Jak je používat:
1. Klepněte na ikonu **+** (Přidat) vedle rozbalovacího menu „Flashing Profile“ v kartě **Configuration Options**.
2. Pojmenujte svůj nový profil a přizpůsobte nastavení. Úpravy se automaticky ukládají okamžitě.
3. Vyberte libovolný profil z rozbalovacího menu pro automatickou výměnu všech parametrů.
4. Chcete-li profil smazat, vyberte jej a klepněte na ikonu koše/smazání (musíte mít alespoň dva profily, abyste jeden mohli smazat).

## Dostávám chybu „Not enough space“ při nahrávání mého ESP8285 receiveru.
Čipy ESP8285 (jako ty, které se nacházejí na mnoha AIO boards) mají celkovou fyzickou paměť pouze 1MB. Přímá aktualizace na hlavní vydání (například z 3.x na 4.x) přes Wi-Fi může vyčerpat prostor pro duální oddíly, protože příchozí soubor je příliš velký na to, aby se rozbalil vedle aktuálně běžícího firmware.

**Jak to opravit:** Nejprve nahrajte svůj receiver na přechodnou verzi (jako je **3.6.3**). Jakmile bude spuštěn úspornější firmware 3.6.3, budete mít dostatek místa na oddílu pro úspěšné nahrání na požadovaný 4.0 target. Alternativně povolte **Expert Mode** v Nastavení, uložte sestavený binary lokálně a nahrajte jej ručně pomocí kabelového Betaflight Passthrough connection.

## Kde najdu ExpressLRS Lua script pro mé rádio?
ELRS Mobile obsahuje univerzální, verzi nezávislý Lua script přímo v sobě! Jak ho získat:
1. Přejděte do **Settings** a zapněte **Expert Mode**.
2. Klepněte na **Export ELRS Lua Script**.
3. Tím se `elrs.lua` uloží přímo do lokálního úložiště vašeho telefonu. Zapněte své rádio a připojte jej k telefonu přes USB, ujistěte se, že na rádiu vyberete režim "USB Storage" a přeneste soubor do složky `SCRIPTS/TOOLS` pomocí správce souborů vašeho telefonu.

**Poznámka:** Před použitím nového scriptu musíte smazat všechny předchozí verze elrs.lua scriptu (např. elrs_v2.lua, elrs_v3.lua atd.) z SD card vašeho rádia.

## Co když se nahrávání nezdaří a mé zařízení přestane reagovat?
Pokud vaše zařízení nereaguje po neúspěšném nahrání, můžete jej snadno obnovit:
1. Podržte BOOT button na zařízení, zatímco jej připojujete přes USB, abyste vstoupili do bootloader mode.
2. Použijte počítač a ELRS Web Flasher k opětovnému nahrání zařízení přes kabelové USB/UART connection.
3. U Wi-Fi-capable devices můžete také podržet BOOT

**Poznámka:** Na Resources Tab je odkaz na video, které ukazuje, jak to provést.

## Mohu uložit soubor firmware do telefonu, aniž bych jej nahrál?
Ano. Přejděte do **Settings** a povolením **Expert Mode** odemknete možnost uložit sestavený firmware binary přímo do lokálního úložiště vašeho mobilního zařízení namísto okamžitého nahrávání Over-The-Air (OTA).

To je obzvláště užitečné, pokud chcete zařízení nahrát ručně pomocí vyhrazeného hardwarového programátoru (jako je STLink nebo FTDI adapter).

## Dostávám chybu „Target Mismatch“. Co mám dělat?
Chyba Target Mismatch nastane, když se hardwarový cíl, který jste vybrali v aplikaci, neshoduje s cílem firmware aktuálně běžícího na zařízení.

Aby se předešlo náhodnému poškození, aplikace vás upozorní, pokud je detekována neshoda. Pokud jste si však jisti, že je vybraný cíl správný (například pokud převádíte zařízení na jinou variantu firmware nebo opravujete předchozí nesprávné nahrání), můžete klepnout na **FORCE FLASH** v dialogovém okně neshody, abyste přepsali kontrolu a pokračovali v nahrání.

<!-- source_hash: 4de4fb02852e8f160449fd60465b7888 -->