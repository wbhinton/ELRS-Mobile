# Návod

## Fáze 1: Kešování firmwaru
1. **Připojení k internetu:** Ujistěte se, že je váš telefon připojen k internetu (např. domácí Wi-Fi nebo mobilní síť).
2. **Otevření Správce firmwaru:** Přejděte do Správce firmwaru (Firmware Manager) v aplikaci.
3. **Stažení verze:** Klepněte na ikonu stahování vedle požadované verze ExpressLRS. Tím se bezpečně uloží potřebné cíle firmwaru a hardwarové definice do vašeho telefonu pro 100% offline použití.

## Fáze 2: Připojení k vašemu zařízení
1. **Zapnutí zařízení:** Zapněte váš ExpressLRS přijímač (RX) nebo vysílač (TX).
2. **Čekání na Hotspot:** Počkejte, až zařízení vstoupí do režimu Wi-Fi Hotspot (indikováno rychlým blikáním LED).
3. **Připojení k Hotspotu:** Připojte Wi-Fi vašeho telefonu k síti `ExpressLRS RX` nebo `ExpressLRS TX` pomocí hesla `expresslrs`.
* **Poznámka:** ELRS Mobile nativně zpracovává vynucené směrování, což zajišťuje, že se váš telefon tiše nepřepne zpět na 5G/LTE.

## Fáze 3: Nahrávání firmwaru
1. **Přejděte na Flash Device:** Z hlavního Dashboardu vyberte **Flash Device**.
2. **Výběr cíle:** Použijte kaskádové rozbalovací nabídky pro výběr výrobce a konkrétního hardwarového cíle.
3. **Výběr verze:** Vyberte dostupnou verzi firmwaru z vašeho offline repozitáře.
4. **Konfigurace a profily:** Vyberte nebo vytvořte **Flashing Profile** (např. "My Quads", "Race Spec") pro načtení vašich vlastních přihlašovacích údajů. Aplikace uchovává Wi-Fi SSID, Wi-Fi Password, Binding Phrase, Regulatory Domain a Auto-On intervaly v těchto pojmenovaných profilech, takže je nemusíte znovu zadávat při přepínání mezi různými nastaveními.
5. **Sestavení a nahrání:** Klepněte na **FLASH**. Systém opraví binární soubor vašimi lokálními přihlašovacími údaji a nahraje jej.
* **Klíčové:** Vždy počkejte na potvrzení úspěchu a na to, až se LED dioda zařízení znovu rozbliká, než jej odpojíte!

---

# Často kladené otázky

## Potřebuji internetové připojení nebo mobilní služby k nahrání firmwaru?
Ne. ELRS Mobile nabízí **100% Offline Flashing**. Pokud jste si předtím stáhli verzi firmwaru přes Firmware Manager, zatímco jste byli připojeni k domácí Wi-Fi, aplikace může dynamicky sestavit a nahrát firmware zcela offline.

## Co jsou Flashing Profiles a jak je používám?
Flashing Profiles vám umožňují uložit a přepínat mezi více konfiguracemi nahrávání (např. "My Quads", "Stock / Factory Reset", "Race Spec"). Každý profil bezpečně ukládá vlastní binding phrase, Wi-Fi SSID, Wi-Fi password, regulatory domains a Wi-Fi auto-on interval.

Jak je používat:
1. Klepněte na ikonu **+** (Přidat) vedle rozbalovací nabídky "Flashing Profile" v kartě **Configuration Options**.
2. Pojmenujte svůj nový profil a přizpůsobte nastavení. Úpravy se automaticky ukládají.
3. Vyberte libovolný profil z rozbalovací nabídky pro automatickou výměnu všech parametrů.
4. Pro smazání profilu jej vyberte a klepněte na ikonu koše/smazání (musíte mít alespoň dva profily, abyste mohli jeden smazat).

## Dostávám chybu "Not enough space" při nahrávání mého ESP8285 přijímače.
Čipy ESP8285 (jako ty, které se nacházejí na mnoha AIO deskách) mají celkem pouze 1 MB fyzického úložiště. Přímá aktualizace na hlavní verzi (například z 3.x na 4.x) přes Wi-Fi může vyčerpat prostor pro duální oddíly, protože příchozí soubor je příliš velký na to, aby se rozbalil vedle aktuálně běžícího firmwaru.

**Jak to opravit:** Nejprve nalaďte svůj přijímač na přechodnou verzi (například **3.6.3**). Jakmile bude běžet štíhlejší firmware 3.6.3, budete mít dostatek prostoru pro oddíly k úspěšnému nahrání na požadovaný cíl 4.0. Alternativně, povolte **Expert Mode** v Settings, uložte sestavený binární soubor lokálně a nahrajte jej ručně přes drátové Betaflight Passthrough připojení.

## Kde najdu skript ExpressLRS Lua pro své rádio?
ELRS Mobile je dodáván s univerzálním, verzí-agnostickým Lua skriptem, který je součástí aplikace! Jak ho získat:
1. Přejděte do **Settings** a přepněte na **Expert Mode**.
2. Klepněte na **Export ELRS Lua Script**.
3. Tím se uloží `elrs.lua` přímo do lokálního úložiště vašeho telefonu. Zapněte rádio a připojte jej k telefonu přes USB, ujistěte se, že na rádiu vyberete režim "USB Storage" a přeneste soubor do složky `SCRIPTS/TOOLS` pomocí správce souborů vašeho telefonu.

**Poznámka:** Před použitím nového skriptu musíte z SD karty rádia smazat všechny předchozí verze skriptu elrs.lua (např. elrs_v2.lua, elrs_v3.lua atd.).

## Co když nahrání selže a mé zařízení přestane reagovat?
Pokud vaše zařízení nereaguje po neúspěšném nahrání, můžete jej snadno obnovit:
1. Podržte tlačítko BOOT na zařízení, zatímco jej připojíte přes USB, abyste vstoupili do režimu bootloaderu.
2. Použijte počítač a ELRS Web Flasher k opětovnému nahrání zařízení přes drátové USB/UART připojení.
3. Pro zařízení s podporou Wi-Fi můžete také podržet BOOT

**Poznámka:** Na kartě Resources je odkaz na video, které ukazuje, jak to provést.

## Mohu uložit soubor firmwaru do telefonu bez jeho nahrání?
Ano. Přejděte do **Settings** a povolte **Expert Mode**, čímž odemknete možnost uložit sestavený binární soubor firmwaru přímo do lokálního úložiště vašeho mobilního zařízení, namísto jeho okamžitého nahrání Over-The-Air (OTA).

To je obzvláště užitečné, pokud chcete nahrát zařízení ručně pomocí specializovaného hardwarového programátoru (jako je STLink nebo FTDI adaptér).

## Dostávám chybu "Target Mismatch". Co mám dělat?
Chyba target mismatch nastane, když se hardwarový cíl, který jste vybrali v aplikaci, neshoduje s cílem firmwaru aktuálně běžícího na zařízení.

Aby se zabránilo náhodnému poškození, aplikace vás upozorní, pokud je detekována neshoda. Nicméně, pokud si jste jisti, že je vybraný cíl správný (například, pokud přev��díte zařízení na jinou variantu firmwaru nebo opravujete předchozí nesprávné nahrání), můžete klepnout na **FORCE FLASH** v dialogovém okně neshody, abyste přepsali kontrolu a pokračovali v nahrání.

<!-- source_hash: 4de4fb02852e8f160449fd60465b7888 -->