---
title: "Uživatelská příručka"
slug: cs/user_guide
sidebar:
  order: 1
---

ELRS Mobile flashuje a konfiguruje přijímače (RX) a vysílače (TX) ExpressLRS z vašeho telefonu, přes Wi-Fi, bez nutnosti notebooku a připojení k internetu v terénu. Funguje s hardwarem založeným na ESP (ESP8285, ESP32, ESP32-C3, ESP32-S3) a firmwarem ExpressLRS 3.3.x a 4.x. Všechna kompatibilní zařízení naleznete v části [Podporovaný hardware](/supported_hardware).

Pracovní postup má dvě části: stažení firmwaru, když máte internet, a následné flashování kdekoli.

---

## Instalace

| Platforma | Kde získat |
| :--- | :--- |
| Android | [Google Play](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile) |
| iPhone a iPad | [App Store](https://apps.apple.com/us/app/elrs-mobile/id6760490014) |
| Android, bez Google Play | [Přímé stažení APK](https://cdn.elrsmobile.com/ELRS-Mobile-latest.apk), [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases), nebo [GitHub Store](https://github.com/OpenHub-Store/Github-Store) |

Verze z obchodů se aktualizují přes Google Play a App Store. APK stažené přímo kontroluje novou verzi jednou denně a nabízí její stažení; můžete také kdykoli zkontrolovat aktualizace v **Settings → About & Legal → Check for Updates**, přeskočit verzi nebo si nechat připomenout později. Vaše nastavení a profily se při instalaci aktualizace zachovají.

Chcete nové funkce dříve? Připojte se k [beta verzi Google Play](https://play.google.com/apps/testing/io.datarx.elrsmobile) nebo k [beta verzi TestFlight](https://testflight.apple.com/join/jwU1WrpX).

Při prvním spuštění aplikace zobrazí krátké prohlášení. Flashování firmwaru vždy nese určité riziko pro váš hardware; přijměte ho pro pokračování.

---

## Rychlý start: flashování prvního zařízení

### Krok 1: Stažení firmwaru (doma)

1.  Na Dashboardu otevřete **Firmware Manager**.
2.  Klepněte na ikonu stahování vedle verze ExpressLRS, kterou chcete. Jsou uvedeny pouze verze 3.3.0 a novější: jedná se o první verze s jednotným firmwarem, na kterém ELRS Mobile staví.
3.  Po dokončení stahování se u verze zobrazí **Ready for offline use**. Firmware a hardwarové definice, které potřebuje, jsou nyní uloženy ve vašem telefonu.

Stáhněte si firmware na domácí Wi-Fi nebo mobilních datech. Nemůžete stahovat, když je váš telefon připojen k Wi-Fi hotspotu přijímače nebo vysílače, protože tato síť nemá internet.

Hlavička ukazuje, kolik verzí jste uložili oproti vašemu limitu. Změňte limit v **Settings → App & Storage → Max Cached Versions** a smažte verze, které již nepotřebujete.

### Krok 2: Připojení k vašemu zařízení

1.  Zapněte přijímač nebo vysílač a počkejte, až spustí svůj Wi-Fi hotspot. Ve výchozím nastavení se to stane 60 sekund po zapnutí, pokud se nepřipojil k partnerovi. Vysílače mohou také spustit Wi-Fi z ExpressLRS Lua skriptu na vašem rádiu.
2.  Na telefonu se připojte k síti **ExpressLRS RX** nebo **ExpressLRS TX**. Heslo je `expresslrs`.
3.  Otevřete ELRS Mobile. Dashboard automaticky najde zařízení a zobrazí jeho název produktu, verzi firmwaru, cíl a regulační doménu.

Pokud se na Dashboardu zobrazí **No Device Found**, klepněte na **Retry**. Pokud je vaše zařízení v jiné síti (například připojeno k vaší domácí Wi-Fi), klepněte na ikonu ozubeného kola na kartě zařízení a zadejte jeho IP adresu.

Zařízení s firmwarem starším než 3.1 jsou také detekována, takže je můžete aktualizovat na aktuální verzi.

### Krok 3: Flashování

1.  Na Dashboardu klepněte na **Flash Device**.
2.  Zkontrolujte cíl. Aplikace předvybere cíl, který odpovídá připojenému zařízení, pokud to jde; jinak zvolte Device Type, Device Vendor, Regulatory & Frequency a Device Target.
3.  Vyberte verzi firmwaru. Verze, které jste stáhli, jsou označeny **(Cached)**. Pokud hardware potřebuje novější verzi, než máte, aplikace to oznámí a nabídne stažení kompatibilní verze.
4.  Zkontrolujte možnosti firmwaru: flashing profile, binding phrase, Wi-Fi network and password, regulatory domain a Wi-Fi auto-on interval.
5.  Klepněte na **Flash**.

Ukazatel průběhu sleduje každý krok: lokalizace a rozbalení staženého firmwaru, jeho sestavení s vaším nastavením, nahrání a **Writing to Device — Please Wait**, zatímco zařízení jej instaluje a restartuje se. Když zařízení potvrdí, uvidíte **Flashing Successful! Device is rebooting** a Dashboard se znovu připojí, jakmile je zpět.

---

## Bezpečnostní kontroly

Aplikace před flashováním kontroluje vaše volby a zastaví se, pokud se něco zdá být špatně.

:::danger[Nekompatibilní čip]
Firmware pro jeden čip nikdy nemůže běžet na jiném (například firmware ESP32 na přijímači ESP8285). Aplikace zablokuje flashování a sdělí vám, o jaký čip se jedná. Vyberte cíl pro čip vašeho zařízení.
:::

:::caution[Nesoulad cíle]
Pokud vybraný cíl neodpovídá produktu, který zařízení hlásí, uvidíte **Target Mismatch**. Nejprve zkontrolujte svůj výběr. Pokud jste si jisti, že je správný (například se zotavujete ze špatného flashování nebo přecházíte na novější definici cíle), klepněte na **Force Flash**.
:::

:::note[Žádná vazebná fráze]
Flashování bez vazebné fráze funguje, ale zařízení se spáruje pouze pomocí výchozí (prázdné) fráze. Aplikace se před pokračováním zeptá.
:::

:::caution[Flash nepotvrzen]
Pokud se zařízení odpojí před potvrzením flashování (ztratilo napájení, restartovalo se nebo se přerušilo Wi-Fi připojení), aplikace nemůže říci, zda se aktualizace dokončila. Místo ohlášení úspěchu zobrazí oranžové varování. Znovu se připojte a zkontrolujte verzi firmwaru na Dashboardu; pokud se nezměnila, flashněte znovu.
:::

---

## Flashing profily

Flashing profile uloží vazebnou frázi, domácí Wi-Fi síť a heslo, výchozí regulační domény a interval automatického zapnutí Wi-Fi pod názvem. Použijte jeden pro každou flotilu nebo rádiové nastavení a přepínejte mezi nimi jediným klepnut��m.

Profily spravujte v **Settings → Profiles & Network**:

-   **Add:** klepněte na **+**, zadejte název a klepněte na **Add**.
-   **Switch:** vyberte profil ze seznamu **Flashing Profile**. Je také k dispozici na obrazovce flashování.
-   **Edit:** změňte libovolné pole; aktivní profil se automaticky uloží.
-   **Delete:** vyberte profil a klepněte na ikonu odstranění. Vždy si ponecháte alespoň jeden profil.

Vazebné fráze a Wi-Fi hesla jsou uloženy v šifrovaném zabezpečeném úložišti vašeho telefonu.

---

## Konfigurace zařízení

Na Dashboardu klepněte na **Device Config** pro otevření vlastní stránky nastavení ExpressLRS připojeného zařízení v aplikaci. Použijte ji ke změně nastavení Wi-Fi a vazby, model match, sériového protokolu, mapování výstupu PWM a dalších možností zařízení. Aplikace udržuje stránku zamčenou k vašemu zařízení.

---

## Nastavení

| Sekce | Co tam je |
| :--- | :--- |
| Profiles & Network | Flashing profily, vazebná fráze, domácí Wi-Fi síť a heslo, výchozí regulační domény 2.4 GHz a sub-GHz |
| App & Storage | Maximální počet uložených verzí, Firmware Manager, vyčištění cache firmwaru, jazyk aplikace, anonymní analytika používání (ve výchozím nastavení zapnuto; vypněte pomocí **Share Analytics**) |
| Advanced & Debug | Expert Mode a jeho nástroje (níže) |
| About & Legal | Verze aplikace, právní upozornění a licence, podpora vývoje a **Check for Updates** v APK staženém přímo |

Změňte jazyk aplikace z Nastavení nebo tlačítka jazyka v horní liště. ELRS Mobile je k dispozici v 18 jazycích.

---

## Expert Mode

Zapněte **Settings → Advanced & Debug → Expert Mode** pro odemknutí:

-   **STM32 targets.** Starší hardware založený na STM32 nelze flashovat přes Wi-Fi a podporuje ho pouze ExpressLRS 3.3.x. Aplikace sestaví firmware s vaším nastavením, takže jej můžete flashovat z PC pomocí STLinku nebo Betaflight passthrough.
-   **Download Binary.** Uložte sestavený soubor firmwaru místo jeho flashování, pro ruční flashování nebo audit.
-   **Export ELRS Lua Script.** Uložte `elrs.lua` pro rádia EdgeTX a OpenTX.
-   **Submit Debug Report.** Odešlete informace o zařízení a protokoly aplikací, abyste pomohli opravit chybu. Vazebné fráze a Wi-Fi hesla nejsou nikdy zahrnuty.

---

## Řešení problémů

**Dashboard nemůže najít mé zařízení.** Ujistěte se, že váš telefon je stále připojen k Wi-Fi síti zařízení; některé telefony opouštějí sítě, které nemají internet. Na Androidu ELRS Mobile udržuje svůj provoz na této Wi-Fi síti i bez internetu. Klepněte na **Retry** nebo zadejte IP adresu z ikony ozubeného kola (`10.0.0.1` na vlastním hotspotu zařízení).

**Nemohu stáhnout firmware.** Odpojte se od hotspotu zařízení a použijte síť s internetem.

**Moje zařízení nereaguje po neúspěšném flashování.** Podržte tlačítko BOOT a připojte ho přes USB pro vstup do režimu bootloaderu, poté znovu flashněte pomocí [ExpressLRS Web Flasher](https://expresslrs.org/flasher). Zařízení s podporou Wi-Fi lze také obnovit podržením BOOT po dobu 60 sekund pro spuštění Wi-Fi hotspotu. Obrazovka **Help & Support** v aplikaci obsahuje tyto kroky, FAQ a odkazy na ExpressLRS Discord.

**Mé profily zmizely po aktualizaci.** Aktualizace přímo z v1.0.43 nebo starší na v1.0.45 nebo novější nemůže přenést uložené profily, vazebné fráze a nastavení Wi-Fi přes aktualizaci úložiště. Aplikace vás jednou upozorní; zadejte je znovu v Settings.

---

Vývojáři mohou ověřit firmware, který ELRS Mobile sestaví, pomocí [Firmware Validation Tools](/firmware-validation).
