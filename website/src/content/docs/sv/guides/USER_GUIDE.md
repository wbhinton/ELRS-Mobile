---
title: "Användarhandbok"
slug: sv/user_guide
sidebar:
  order: 1
---

ELRS Mobile flashar och konfigurerar ExpressLRS-mottagare (RX) och sändare (TX) från din telefon, över Wi-Fi, utan laptop och utan internetuppkoppling ute på fältet. Det fungerar med ESP-baserad hårdvara (ESP8285, ESP32, ESP32-C3, ESP32-S3) och ExpressLRS 3.3.x samt 4.x firmware. Se [Kompatibel hårdvara](/supported_hardware) för varje kompatibel enhet.

Arbetsflödet består av två delar: ladda ner firmware när du har internet, sedan flasha var som helst.

---

## Installation

| Plattform | Var du hittar den |
| :--- | :--- |
| Android | [Google Play](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile) |
| iPhone och iPad | [App Store](https://apps.apple.com/us/app/elrs-mobile/id6760490014) |
| Android, utan Google Play | [Direkt APK-nedladdning](https://cdn.elrsmobile.com/ELRS-Mobile-latest.apk), [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases), eller [GitHub Store](https://github.com/OpenHub-Store/Github-Store) |

Butiksversionerna uppdateras via Google Play och App Store. APK:n för direkttillgänglig nedladdning kontrollerar om det finns en ny version en gång om dagen och erbjuder att ladda ner den; du kan också kontrollera när som helst från **Inställningar → Om & Juridiskt → Sök efter uppdateringar**, hoppa över en version eller bli påmind senare. Dina inställningar och profiler behålls när du installerar en uppdatering.

Vill du ha nya funktioner tidigt? Gå med i [Google Play-betan](https://play.google.com/apps/testing/io.datarx.elrsmobile) eller [TestFlight-betan](https://testflight.apple.com/join/jwU1WrpX).

Vid första start visar appen en kort ansvarsfriskrivning. Att flasha firmware medför alltid en viss risk för din hårdvara; acceptera för att fortsätta.

---

## Snabbstart: flasha din första enhet

### Steg 1: Ladda ner firmware (hemma)

1. På Dashboard, öppna **Firmware Manager**.
2. Tryck på nedladdningsikonen bredvid den ExpressLRS-version du vill ha. Endast versioner 3.3.0 och nyare listas: de är de första med den enhetliga firmware som ELRS Mobile bygger på.
3. När nedladdningen är klar visar versionen **Klar för offlineanvändning**. Firmware och de hårdvarudefinitioner den behöver är nu lagrade på din telefon.

Ladda ner firmware via ditt hem-Wi-Fi eller mobildata. Du kan inte ladda ner medan din telefon är ansluten till en mottagares eller sändares Wi-Fi hotspot, eftersom det nätverket inte har internet.

Rubriken visar hur många versioner du har lagrat mot din gräns. Ändra gränsen i **Inställningar → App & Lagring → Max antal cachade versioner**, och ta bort versioner du inte längre behöver.

### Steg 2: Anslut till din enhet

1. Slå på din mottagare eller sändare och vänta tills den startar sin Wi-Fi hotspot. Som standard sker detta 60 sekunder efter uppstart om den inte har anslutit till sin partner. Sändare kan också starta Wi-Fi från ExpressLRS Lua-skriptet på din radio.
2. På din telefon, anslut till nätverket **ExpressLRS RX** eller **ExpressLRS TX**. Lösenordet är `expresslrs`.
3. Öppna ELRS Mobile. Dashboard hittar enheten automatiskt och visar dess produktnamn, firmware-version, target och regulatory domain.

Om Dashboard visar **Ingen enhet hittades**, tryck på **Försök igen**. Om din enhet är på ett annat nätverk (till exempel ansluten till ditt hem-Wi-Fi), tryck på kugghjulsikonen på enhetskortet och ange dess IP-adress.

Enheter med firmware äldre än 3.1 upptäcks också, så att du kan uppdatera dem till en aktuell version.

### Steg 3: Flash

1. På Dashboard, tryck på **Flash enhet**.
2. Kontrollera target. Appen förväljer target som matchar den anslutna enheten när den kan; annars välj Enhetstyp, Enhetsleverantör, Regulatorisk & Frekvens, och Enhets-target.
3. Välj firmware-version. Versioner du har laddat ner är markerade **(Cachad)**. Om hårdvaran behöver en nyare version än du har, meddelar appen det och erbjuder att ladda ner en kompatibel.
4. Kontrollera firmware-alternativen: flashningsprofil, binding phrase, Wi-Fi-nätverk och lösenord, regulatory domain, och Wi-Fi auto-on intervall.
5. Tryck på **Flash**.

Progressfältet följer varje steg: lokalisering och uppackning av din nedladdade firmware, byggande av den med dina inställningar, uppladdning, och **Skriver till enhet – Var god vänta** medan enheten installerar den och startar om. När enheten bekräftar, kommer du att se **Flashning lyckades! Enheten startar om**, och Dashboard återansluter när den är tillbaka.

---

## Säkerhetskontroller

Appen kontrollerar dina val innan flashning och stoppar om något ser fel ut.

:::danger[Inkompatibel chip]
Firmware för ett chip kan aldrig köras på ett annat (till exempel ESP32 firmware på en ESP8285-mottagare). Appen blockerar flashningen och talar om vilket chip varje är. Välj en target för din enhets chip.
:::

:::caution[Target-matchningsfel]
Om den valda target inte matchar produkten som enheten rapporterar, kommer du att se **Target-matchningsfel**. Kontrollera ditt val först. Om du är säker på att det är rätt (till exempel återställer från en dålig flashning eller flyttar till en nyare target-definition), tryck på **Tvinga flash**.
:::

:::note[Ingen binding phrase]
Flashning utan en binding phrase fungerar, men enheten kommer endast att binda med standard (tom) phrase. Appen frågar innan du fortsätter.
:::

:::caution[Flashning ej bekräftad]
Om enheten kopplas bort innan den bekräftar flashningen (den förlorade strömmen, startade om, eller Wi-Fi-länken tappades), kan appen inte avgöra om uppdateringen slutfördes. Den visar en gul varning istället för att rapportera framgång. Återanslut och kontrollera firmware-versionen på Dashboard; om den inte har ändrats, flasha igen.
:::

---

## Flashningsprofiler

En flashningsprofil sparar en binding phrase, hem-Wi-Fi-nätverk och lösenord, standard regulatory domains, och Wi-Fi auto-on intervall under ett namn. Använd en per flotta eller radioinställning, och växla mellan dem med ett tryck.

Hantera profiler i **Inställningar → Profiler & Nätverk**:

- **Lägg till:** tryck på +, skriv ett namn och tryck på Lägg till.
- **Växla:** välj en profil från listan **Flashningsprofil**. Den är också tillgänglig på flashningsskärmen.
- **Redigera:** ändra vilket fält som helst; den aktiva profilen sparas automatiskt.
- **Ta bort:** välj profilen och tryck på ta bort-ikonen. Du behåller alltid minst en profil.

Binding phrases och Wi-Fi-lösenord lagras i telefonens krypterade säkra lagring.

---

## Enhetskonfiguration

På Dashboard, tryck på **Device Config** för att öppna den anslutna enhetens egen ExpressLRS-inställningssida i appen. Använd den för att ändra Wi-Fi- och binding-inställningar, model match, serial protocol, PWM output mapping och andra enhetsalternativ. Appen håller sidan låst till din enhet.

---

## Inställningar

| Sektion | Vad som finns där |
| :--- | :--- |
| Profiler & Nätverk | Flashningsprofiler, binding phrase, hem-Wi-Fi-nätverk och lösenord, standard 2.4 GHz och sub-GHz regulatory domains |
| App & Lagring | Max antal cachade versioner, Firmware Manager, rensa firmware-cachen, app-språk, anonym användningsanalys (på som standard; stäng av med **Dela analysdata**) |
| Avancerat & Felsökning | Expertläge och dess verktyg (nedan) |
| Om & Juridiskt | Appversion, juridisk information och licens, stöd utvecklingen, och **Sök efter uppdateringar** i APK för direkt nedladdning |

Ändra app-språket från Inställningar eller språkkappen i toppfältet. ELRS Mobile finns tillgänglig på 18 språk.

---

## Expertläge

Slå på **Inställningar → Avancerat & Felsökning → Expertläge** för att låsa upp:

- **STM32-targets.** Äldre STM32-baserad hårdvara kan inte flashas över Wi-Fi, och endast ExpressLRS 3.3.x stöder det. Appen bygger firmware med dina inställningar så att du kan flasha den från en PC med en STLink eller Betaflight passthrough.
- **Ladda ner binärfil.** Spara den byggda firmware-filen istället för att flasha den, för manuell flashning eller granskning.
- **Exportera ELRS Lua-skript.** Spara `elrs.lua` för EdgeTX- och OpenTX-radios.
- **Skicka felsökningsrapport.** Skicka enhetsinformation och app-loggar för att hjälpa till att åtgärda en bugg. Binding phrases och Wi-Fi-lösenord inkluderas aldrig.

---

## Felsökning

**Dashboard kan inte hitta min enhet.** Se till att din telefon fortfarande är ansluten till enhetens Wi-Fi-nätverk; vissa telefoner lämnar nätverk som inte har internet. På Android behåller ELRS Mobile sin trafik på det Wi-Fi-nätverket även utan internet. Tryck på **Försök igen**, eller ange IP-adressen från kugghjulsikonen (`10.0.0.1` på enhetens egen hotspot).

**Jag kan inte ladda ner firmware.** Koppla bort från enhetens hotspot och använd ett nätverk med internet.

**Min enhet svarar inte efter en misslyckad flashning.** Håll in BOOT-knappen medan du ansluter den via USB för att gå in i bootloader-läge, flasha sedan om med [ExpressLRS Web Flasher](https://expresslrs.org/flasher). Wi-Fi-kapabla enheter kan också återställas genom att hålla in BOOT i 60 sekunder för att starta Wi-Fi hotspot. Skärmen för **Hjälp & Support** i appen innehåller dessa steg, en FAQ, och länkar till ExpressLRS Discord.

**Mina profiler försvann efter uppdatering.** Uppdatering direkt från v1.0.43 eller äldre till v1.0.45 eller nyare kan inte överföra sparade profiler, binding phrases och Wi-Fi-inställningar över en lagringsuppgradering. Appen meddelar dig en gång; ange dem igen i Inställningar.

---

Utvecklare kan verifiera den firmware ELRS Mobile bygger med [Verktyg för firmware-validering](/firmware-validation).

<!-- source_hash: 927017dfd36d96b7c787e4972528233d -->