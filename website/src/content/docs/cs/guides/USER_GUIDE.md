---
title: "Uživatelská příručka"
slug: cs/user_guide
sidebar:
  order: 1
---

ELRS Mobile flashuje a konfiguruje ExpressLRS přijímače (RX) a vysílače (TX) z vašeho telefonu, přes Wi-Fi, bez notebooku a bez připojení k internetu na poli. Funguje s hardwarem založeným na ESP (ESP8285, ESP32, ESP32-C3, ESP32-S3) a firmwarem ExpressLRS 3.3.x a 4.x. Viz [Podporovaný hardware](/supported_hardware) pro všechna kompatibilní zařízení.

Pracovní postup má dvě části: stáhněte firmware, když máte internet, a poté flashujte kdekoli.

---

## Instalace

| Platforma | Kde ji získat |
| :--- | :--- |
| Android | [Google Play](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile) |
| iPhone a iPad | [App Store](https://apps.apple.com/us/app/elrs-mobile/id6760490014) |
| Android, bez Google Play | [Přímé stažení APK](https://cdn.elrsmobile.com/ELRS-Mobile-latest.apk), [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases), nebo [GitHub Store](https://github.com/OpenHub-Store/Github-Store) |

Verze z obchodů se aktualizují přes Google Play a App Store. APK pro přímé stažení kontroluje novou verzi jednou denně a nabízí její stažení; můžete také kdykoli zkontrolovat v **Nastavení → O aplikaci a právní informace → Zkontrolovat aktualizace**, přeskočit verzi nebo si nechat připomenout později. Vaše nastavení a profily jsou zachovány při instalaci aktualizace.

Chcete nové funkce dříve? Připojte se k [beta verzi na Google Play](https://play.google.com/apps/testing/io.datarx.elrsmobile) nebo k [beta verzi TestFlight](https://testflight.apple.com/join/jwU1WrpX).

Při prvním spuštění aplikace zobrazí krátké prohlášení. Flashování firmwaru vždy nese určité riziko pro váš hardware; přijměte ho pro pokračování.

---

## Rychlý start: flashování prvního zařízení

### Krok 1: Stáhněte firmware (doma)

1.  Na Ovládacím panelu otevřete **Správce firmwaru**.
2.  Klepněte na ikonu stahování vedle verze ExpressLRS, kterou chcete. Jsou uvedeny pouze verze 3.3.0 a novější: jsou to první verze s jednotným firmwarem, na kterém ELRS Mobile staví.
3.  Po dokončení stahování verze zobrazí **Připraveno pro offline použití**. Firmware a definice hardwaru, které potřebuje, jsou nyní uloženy ve vašem telefonu.

Stáhněte firmware na vaší domácí Wi-Fi nebo mobilních datech. Nemůžete stahovat, když je váš telefon připojen k Wi-Fi hotspotu přijímače nebo vysílače, protože tato síť nemá internet.

Záhlaví ukazuje, kolik verzí jste uložili oproti vašemu limitu. Změňte limit v **Nastavení → Aplikace a úložiště → Max. uložených verzí** a odstraňte verze, které již nepotřebujete.

### Krok 2: Připojte se k zařízení

1.  Zapněte přijímač nebo vysílač a počkejte, až spustí svůj Wi-Fi hotspot. Ve výchozím nastavení se to stane 60 sekund po zapnutí, pokud se nepřipojil k partnerovi. Vysílače mohou také spustit Wi-Fi z ExpressLRS Lua skriptu na vašem rádiu.
2.  Na telefonu se připojte k síti **ExpressLRS RX** nebo **ExpressLRS TX**. Heslo je `expresslrs`.
3.  Otevřete ELRS Mobile. Ovládací panel zařízení automaticky najde a zobrazí jeho název produktu, verzi firmwaru, cíl a regulační doménu.

Pokud Ovládací panel zobrazuje **Zařízení nenalezeno**, klepněte na **Opakovat**. Pokud je vaše zařízení v jiné síti (například připojeno k vaší domácí Wi-Fi), klepněte na ikonu ozubeného kola na kartě zařízení a zadejte jeho IP adresu.

Zařízení s firmwarem starším než 3.1 jsou také detekována, takže je můžete aktualizovat na aktuální verzi.

### Krok 3: Flashování

1.  Na Ovládacím panelu klepněte na **Flashovat zařízení**.
2.  Zkontrolujte cíl. Aplikace předvybere cíl, který odpovídá připojenému zařízení, pokud to je možné; jinak zvolte Typ zařízení, Výrobce zařízení, Regulace a frekvence a Cíl zařízení.
3.  Zvolte verzi firmwaru. Verze, které jste stáhli, jsou označeny **(Cached)**. Pokud hardware potřebuje novější verzi, než máte, aplikace to oznámí a nabídne stažení kompatibilní verze.
4.  Zkontrolujte možnosti firmwaru: profil flashování, vazební fráze, Wi-Fi síť a heslo, regulační doména a interval automatického zapnutí Wi-Fi.
5.  Klepněte na **Flashovat**.

Indikátor průběhu sleduje každý krok: nalezení a rozbalení staženého firmwaru, jeho sestavení s vaším nastavením, nahrání a **Zápis do zařízení – čekejte prosím**, zatímco zařízení instaluje a restartuje. Když zařízení potvrdí, uvidíte **Flashování úspěšné! Zařízení se restartuje** a Ovládací panel se znovu připojí, jakmile bude zpět.

---

## Bezpečnostní kontroly

Aplikace kontroluje vaše volby před flashováním a zastaví se, pokud se něco zdá být špatně.

:::danger[Nekompatibilní čip]
Firmware pro jeden čip nikdy nemůže běžet na jiném (například firmware ESP32 na přijímači ESP8285). Aplikace zablokuje flashování a sdělí vám, jaký čip každý z nich je. Zvolte cíl pro čip vašeho zařízení.
:::

:::caution[Neshoda cíle]
Pokud se vybraný cíl neshoduje s produktem, který zařízení hlásí, uvidíte **Neshoda cíle**. Nejprve zkontrolujte svůj výběr. Pokud jste si jisti, že je správný (například se zotavujete z neúspěšného flashování nebo přecházíte na novější definici cíle), klepněte na **Vynutit flashování**.
:::

:::note[Žádná vazební fráze]
Flashování bez vazební fráze funguje, ale zařízení se spáruje pouze pomocí výchozí (prázdné) fráze. Aplikace se zeptá před pokračováním.
:::

:::caution[Flashování nepotvrzeno]
Pokud se zařízení odpojí před potvrzením flashování (ztratilo napájení, restartovalo se nebo se přerušilo Wi-Fi spojení), aplikace nedokáže zjistit, zda se aktualizace dokončila. Místo ohlášení úspěchu zobrazí oranžové upozornění. Znovu se připojte a zkontrolujte verzi firmwaru na Ovládacím panelu; pokud se nezměnila, flashujte znovu.
:::

---

## Profily flashování

Profil flashování ukládá vazební frázi, domácí Wi-Fi síť a heslo, výchozí regulační domény a interval automatického zapnutí Wi-Fi pod názvem. Použijte jeden pro každou flotilu nebo nastavení rádia a přepínejte mezi nimi jedním klepnutím.

Spravujte profily v **Nastavení → Profily a síť**:

-   **Přidat:** klepněte na **+**, zadejte jméno a klepněte na **Přidat**.
-   **Přepnout:** vyberte profil ze seznamu **Profil flashování**. Je také k dispozici na obrazovce flashování.
-   **Upravit:** změňte libovolné pole; aktivní profil se automaticky uloží.
-   **Smazat:** vyberte profil a klepněte na ikonu smazání. Vždy si ponecháte alespoň jeden profil.

Vazební fráze a hesla Wi-Fi jsou uloženy v šifrovaném zabezpečeném úložišti vašeho telefonu.

---

## Konfigurace zařízení

Na Ovládacím panelu klepněte na **Konfigurace zařízení** pro otevření vlastní stránky nastavení ExpressLRS připojeného zařízení uvnitř aplikace. Použijte ji ke změně nastavení Wi-Fi a vazby, shody modelu, sériového protokolu, mapování výstupu PWM a dalších možností zařízení. Aplikace udržuje stránku zamčenou k vašemu zařízení.

---

## Nastavení

| Sekce | Co tam najdete |
| :--- | :--- |
| Profily a síť | Profily flashování, vazební fráze, domácí Wi-Fi síť a heslo, výchozí regulační domény 2.4 GHz a sub-GHz |
| Aplikace a úložiště | Max. uložených verzí, Správce firmwaru, vymazání cache firmwaru, jazyk aplikace, anonymní analýza použití (ve výchozím nastavení zapnuta; vypněte pomocí **Sdílet analýzy**) |
| Pokročilé a ladění | Expert Mode a jeho nástroje (níže) |
| O aplikaci a právní informace | Verze aplikace, právní upozornění a licence, podpora vývoje a **Zkontrolovat aktualizace** v APK pro přímé stažení |

Změňte jazyk aplikace v Nastavení nebo tlačítkem jazyka v horní liště. ELRS Mobile je k dispozici v 18 jazycích.

---

## Expert Mode

Zapněte **Nastavení → Pokročilé a ladění → Expert Mode** pro odemknutí:

-   **Cíle STM32.** Starší hardware založený na STM32 nelze flashovat přes Wi-Fi a podporuje ho pouze ExpressLRS 3.3.x. Aplikace sestaví firmware s vaším nastavením, takže jej můžete flashovat z PC pomocí STLink nebo Betaflight passthrough.
-   **Stáhnout binární soubor.** Uložte sestavený soubor firmwaru namísto jeho flashování, pro ruční flashování nebo auditování.
-   **Exportovat ELRS Lua Script.** Uložte `elrs.lua` pro rádia EdgeTX a OpenTX.
-   **Odeslat zprávu o ladění.** Odešlete informace o zařízení a protokoly aplikace, abyste pomohli opravit chybu. Vazební fráze a hesla Wi-Fi nikdy nejsou zahrnuty.

---

## Řešení problémů

**Ovládací panel nemůže najít mé zařízení.** Ujistěte se, že je váš telefon stále připojen k Wi-Fi síti zařízení; některé telefony opouštějí sítě, které nemají internet. Na Androidu ELRS Mobile udržuje svůj provoz na této Wi-Fi síti i bez internetu. Klepněte na **Opakovat**, nebo zadejte IP adresu z ikony ozubeného kola (`10.0.0.1` na vlastním hotspotu zařízení).

**Nemohu stáhnout firmware.** Odpojte se od hotspotu zařízení a použijte síť s internetem.

**Mé zařízení nereaguje po neúspěšném flashování.** Podržte tlačítko BOOT, zatímco jej připojujete přes USB, abyste vstoupili do režimu bootloaderu, a poté znovu flashujte pomocí [ExpressLRS Web Flasher](https://expresslrs.org/flasher). Zařízení s Wi-Fi lze také obnovit podržením tlačítka BOOT po dobu 60 sekund pro spuštění Wi-Fi hotspotu. Obrazovka **Nápověda a podpora** v aplikaci obsahuje tyto kroky, FAQ a odkazy na ExpressLRS Discord.

**Moje profily zmizely po aktualizaci.** Aktualizace přímo z verze 1.0.43 nebo starší na verzi 1.0.45 nebo novější nemůže přenést uložené profily, vazební fráze a nastavení Wi-Fi přes upgrade úložiště. Aplikace vás jednou upozorní; zadejte je znovu v Nastavení.

---

Vývojáři mohou ověřit firmware, který ELRS Mobile sestavuje, pomocí [Nástrojů pro validaci firmwaru](/firmware-validation).

<!-- source_hash: 927017dfd36d96b7c787e4972528233d -->