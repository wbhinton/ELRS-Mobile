# Návod

## Fáze 1: Caching firmwaru
1. **Připojte se k internetu:** Ujistěte se, že je váš telefon připojen k internetu (např. domácí Wi-Fi nebo mobilní síť).
2. **Otevřete Firmware Manager:** Přejděte do Firmware Manageru v aplikaci.
3. **Stáhněte verzi:** Klepněte na ikonu stahování vedle požadované verze ExpressLRS. Tím se bezpečně uloží potřebné firmware targets a hardware definitions na váš telefon pro 100% offline použití.

## Fáze 2: Připojení k vašemu zařízení
1. **Zapněte zařízení:** Zapněte svůj ExpressLRS Receiver (RX) nebo Transmitter (TX).
2. **Počkejte na Hotspot:** Počkejte, dokud zařízení nevstoupí do Wi-Fi Hotspot Mode (signalizováno rychlým blikáním LED diody).
3. **Připojte se k Hotspotu:** Připojte Wi-Fi vašeho telefonu k síti `ExpressLRS RX` nebo `ExpressLRS TX` pomocí hesla `expresslrs`.
* **Poznámka:** ELRS Mobile nativně řeší vynucené směrování, což zajišťuje, že se váš telefon tiše nepřepne zpět na 5G/LTE.

## Fáze 3: Flashování firmwaru
1. **Přejděte na Flash Device:** Z hlavní obrazovky Dashboard vyberte **Flash Device**.
2. **Výběr cíle:** Pomocí rozbalovacích seznamů vyberte výrobce a specifický hardware target.
3. **Výběr verze:** Zvolte dostupnou verzi firmwaru z vašeho offline úložiště.
4. **Konfigurace:** Zadejte své vlastní přihlašovací údaje. Aplikace uchovává WiFi SSID, WiFi Password a Binding Phrase v local storage, takže je nemusíte znovu zadávat.
5. **Sestavení a flashování:** Klepněte na **FLASH**. Systém opraví binární soubor vašimi lokálními přihlašovacími údaji a nahraje jej.
* **Klíčové:** Vždy počkejte na potvrzení úspěchu a na to, až LED dioda zařízení obnoví blikání, než jej odpojíte!

---

# FAQ

## Potřebuji připojení k internetu nebo mobilní služby k flashování firmwaru?
Ne. ELRS Mobile nabízí **100% Offline Flashing**. Dokud jste předtím stáhli verzi firmwaru přes Firmware Manager, zatímco jste byli připojeni k domácí Wi-Fi, aplikace může dynamicky sestavit a flashovat firmware zcela offline.

## Dostávám chybu "Not enough space" při flashování mého ESP8285 receiveru.
Čipy ESP8285 (jako ty, které se nacházejí na mnoha AIO deskách) mají pouze 1MB celkového fyzického úložiště. Přímá aktualizace na hlavní verzi (například z 3.x na 4.x) přes Wi-Fi může vyčerpat prostor pro duální oddíly, protože příchozí soubor je příliš velký na rozbalení vedle aktuálně spuštěného firmwaru.

**Jak to opravit:** Nejprve flashněte váš receiver na mezilehlou verzi (například **3.6.3**). Jakmile bude spuštěn štíhlejší firmware 3.6.3, budete mít dostatek prostoru pro oddíly k úspěšnému flashování na požadovaný cíl 4.0. Alternativně povolte **Expert Mode** v Settings, uložte vytvořený binární soubor lokálně a flashněte jej ručně přes kabelové připojení Betaflight Passthrough.

## Kde najdu ExpressLRS Lua script pro mé rádio?
ELRS Mobile je dodáván s univerzálním, na verzi nezávislým Lua scriptem vestavěným přímo! Jak jej získat:
1. Přejděte do **Settings** a zapněte **Expert Mode**.
2. Klepněte na **Export ELRS Lua Script**.
3. Toto uloží `elrs.lua` přímo do lokálního úložiště vašeho telefonu. Zapněte rádio a připojte jej k telefonu přes USB, ujistěte se, že na rádiu vyberete režim "USB Storage" a přesuňte soubor do složky `SCRIPTS/TOOLS` pomocí správce souborů vašeho telefonu.

**Poznámka:** Před použitím nového skriptu je třeba smazat všechny předchozí verze skriptu elrs.lua (např. elrs_v2.lua, elrs_v3.lua atd.) z SD karty vašeho rádia.

## Co když flashování selže a mé zařízení přestane reagovat?
Pokud vaše zařízení po neúspěšném flashování přestane reagovat, můžete jej snadno obnovit:
1. Podržte tlačítko BOOT na zařízení a připojte jej přes USB, abyste vstoupili do režimu bootloaderu.
2. Použijte počítač a ELRS Web Flasher k opětovnému flashování zařízení přes kabelové připojení USB/UART.
3. U zařízení s podporou Wi-Fi můžete také podržet BOOT

**Poznámka:** Na Resources Tab je odkaz na video, které ukazuje, jak na to.

## Mohu uložit soubor firmwaru do telefonu, aniž bych jej flashoval?
Ano. Přejitím do **Settings** a povolením **Expert Mode** odemknete možnost uložit sestavený binární soubor firmwaru přímo do lokálního úložiště vašeho mobilního zařízení, namísto okamžitého flashování Over-The-Air (OTA).

To je zvláště užitečné, pokud chcete zařízení flashovat ručně pomocí vyhrazeného hardwarového programátoru (jako je adaptér STLink nebo FTDI).

## Dostávám chybu "Target Mismatch". Co mám dělat?
Chyba Target Mismatch nastane, když hardwarový target, který jste vybrali v aplikaci, neodpovídá targetu firmwaru aktuálně běžícího na zařízení.

V současné době aplikace nepodporuje flashování jiného targetu, než je ten, který je aktuálně spuštěn na zařízení.

<!-- source_hash: 32fdb222bf9c42513cbd49e51679ccaa -->