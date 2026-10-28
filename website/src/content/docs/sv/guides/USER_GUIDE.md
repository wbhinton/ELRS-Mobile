---
title: "Användarguide"
slug: sv/user_guide
sidebar:
  order: 1
---

ELRS Mobile flashar och konfigurerar ExpressLRS-mottagare (RX) och sändare (TX) från din telefon, över Wi-Fi, utan laptop och utan internetanslutning ute på fältet. Den fungerar med ESP-baserad hårdvara (ESP8285, ESP32, ESP32-C3, ESP32-S3) och ExpressLRS 3.3.x samt 4.x firmware. Se [Kompatibel hårdvara](/supported_hardware) för varje kompatibel enhet.

Arbetsflödet har två delar: ladda ner firmware när du har internet, och flasha sedan var som helst.

---

## Installation

| Plattform | Var du hittar den |
| :--- | :--- |
| Android | [Google Play](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile) |
| iPhone och iPad | [App Store](https://apps.apple.com/us/app/elrs-mobile/id6760490014) |
| Android, utan Google Play | [Direkt APK-nedladdning](https://cdn.elrsmobile.com/ELRS-Mobile-latest.apk), [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases), eller [GitHub Store](https://github.com/OpenHub-Store/Github-Store) |

Butiksversionerna uppdateras via Google Play och App Store. Den direktnedladdade APK:n söker efter en ny utgåva en gång om dagen och erbjuder sig att ladda ner den; du kan också söka när som helst från **Inställningar → Om & Juridik → Sök efter uppdateringar**, hoppa över en version eller bli påmind senare. Dina inställningar och profiler behålls när du installerar en uppdatering.

Vill du ha nya funktioner tidigt? Gå med i [Google Play beta](https://play.google.com/apps/testing/io.datarx.elrsmobile) eller [TestFlight beta](https://testflight.apple.com/join/jwU1WrpX).

Vid första start visar appen en kort ansvarsfriskrivning. Att flasha firmware medför alltid en viss risk för din hårdvara; acceptera för att fortsätta.

---

## Snabbstart: flasha din första enhet

### Steg 1: Ladda ner firmware (hemma)

1. På Dashboard, öppna **Firmware Manager**.
2. Tryck på nedladdningsikonen bredvid den ExpressLRS-version du vill ha. Endast versioner 3.3.0 och nyare listas: de är de första med den enhetliga firmware som ELRS Mobile bygger på.
3. När nedladdningen är klar visar versionen **Redo för offline-användning**. Firmware och de hårdvarudefinitioner den behöver är nu lagrade på din telefon.

Ladda ner firmware via ditt hem-Wi-Fi eller mobildata. Du kan inte ladda ner medan din telefon är ansluten till en mottagares eller sändares Wi-Fi-hotspot, eftersom det nätverket inte har internet.

Rubriken visar hur många versioner du har lagrat mot din gräns. Ändra gränsen i **Inställningar → App & Lagring → Max antal cachade versioner**, och radera versioner du inte längre behöver.

### Steg 2: Anslut till din enhet

1. Slå på din mottagare eller sändare och vänta tills den startar sin Wi-Fi-hotspot. Som standard händer detta 60 sekunder efter påslagning om den inte har anslutit till sin partner. Sändare kan också starta Wi-Fi från ExpressLRS Lua-skriptet på din radio.
2. På din telefon, anslut till nätverket **ExpressLRS RX** eller **ExpressLRS TX**. Lösenordet är `expresslrs`.
3. Öppna ELRS Mobile. Dashboard hittar enheten automatiskt och visar dess produktnamn, firmware-version, target och regulatoriska domän.

Om Dashboard visar **Ingen enhet hittades**, tryck på **Försök igen**. Om din enhet är på ett annat nätverk (till exempel ansluten till ditt hem-Wi-Fi), tryck på kugghjulsikonen på enhetskortet och ange dess IP-adress.

Enheter som kör firmware äldre än 3.1 upptäcks också, s�� du kan uppdatera dem till en aktuell utgåva.

### Steg 3: Flasha

1. På Dashboard, tryck på **Flasha enhet**.
2. Kontrollera target. Appen förväljer target som matchar den anslutna enheten när det är möjligt; annars välj Enhetstyp, Enhetsleverantör, Regulatorisk & Frekvens, och Enhets-target.
3. Välj firmware-version. Versioner du har laddat ner är markerade **(Cachad)**. Om hårdvaran behöver en nyare version än den du har, säger appen till och erbjuder att ladda ner en kompatibel.
4. Kontrollera firmware-alternativen: flashing-profil, binding phrase, Wi-Fi-nätverk och lösenord, regulatorisk domän, och Wi-Fi auto-on intervall.
5. Tryck på **Flash**.

Framstegsfältet följer varje steg: lokalisera och packa upp din nedladdade firmware, bygga den med dina inställningar, ladda upp den, och **Skriver till enhet – Vänligen vänta** medan enheten installerar den och startar om. När enheten bekräftar ser du **Flashning lyckades! Enheten startar om**, och Dashboard återansluter när den är igång igen.

---

## Säkerhetskontroller

Appen kontrollerar dina val innan flashning och stoppar om något verkar fel.

:::danger[Inkompatibel chip]
Firmware för en chip kan aldrig köras på en annan (till exempel ESP32 firmware på en ESP8285-mottagare). Appen blockerar flashningen och berättar vilken chip det är. Välj en target för din enhets chip.
:::

:::caution[Target-matchningsfel]
Om den valda target inte matchar produkten som enheten rapporterar, ser du **Target-matchningsfel**. Kontrollera ditt val först. Om du är säker på att det är rätt (till exempel återhämtar dig från en misslyckad flashning eller flyttar till en nyare target-definition), tryck på **Tvinga flash**.
:::

:::note[Ingen binding phrase]
Att flasha utan en binding phrase fungerar, men enheten kommer endast att binda med standardfrasen (tom). Appen frågar innan den fortsätter.
:::

:::caution[Flashning inte bekräftad]
Om enheten kopplar bort innan den bekräftar flashningen (den förlorade strömmen, startade om, eller Wi-Fi-länken tappades), kan appen inte avgöra om uppdateringen slutfördes. Den visar en bärnstensfärgad varning istället för att rapportera framgång. Återanslut och kontrollera firmware-versionen på Dashboard; om den inte har ändrats, flasha igen.
:::

---

## Flashing-profiler

En flashing-profil sparar en binding phrase, hem-Wi-Fi-nätverk och lösenord, standard regulatoriska domäner, och Wi-Fi auto-on intervall under ett namn. Använd en per flotta eller radioinställning, och växla mellan dem med ett tryck.

Hantera profiler i **Inställningar → Profiler & Nätverk**:

- **Lägg till:** tryck på **+**, skriv ett namn, och tryck på **Lägg till**.
- **Växla:** välj en profil från listan **Flashing-profil**. Den är också tillgänglig på flashing-skärmen.
- **Redigera:** ändra valfritt fält; den aktiva profilen sparas automatiskt.
- **Radera:** välj profilen och tryck på radera-ikonen. Du behåller alltid minst en profil.

Binding phrases och Wi-Fi-lösenord lagras i telefonens krypterade säkra lagring.

---

## Enhetskonfiguration

På Dashboard, tryck på **Enhetskonfig.** för att öppna den anslutna enhetens egen ExpressLRS-inställningssida inuti appen. Använd den för att ändra Wi-Fi- och binding-inställningar, modellmatchning, seriellt protokoll, PWM-utgångsmappning och andra enhetsalternativ. Appen håller sidan låst till din enhet.

---

## Inställningar

| Sektion | Vad som finns där |
| :--- | :--- |
| Profiler & Nätverk | Flashing-profiler, binding phrase, hem-Wi-Fi-nätverk och lösenord, standard 2.4 GHz och sub-GHz regulatoriska domäner |
| App & Lagring | Max antal cachade versioner, Firmware Manager, rensa firmware-cachen, appspråk, anonym användningsanalys (på som standard; stäng av med **Dela analysdata**) |
| Avancerat & Felsökning | Expertläge och dess verktyg (nedan) |
| Om & Juridik | Appversion, juridiskt meddelande och licens, stödja utveckling, och **Sök efter uppdateringar** i den direktnedladdade APK:n |

Ändra appspråket från Inställningar eller språkknappen i toppmenyn. ELRS Mobile finns tillgänglig på 18 språk.

---

## Expertläge

Slå på **Inställningar → Avancerat & Felsökning → Expertläge** för att låsa upp:

- **STM32 targets.** Äldre STM32-baserad hårdvara kan inte flashas över Wi-Fi, och endast ExpressLRS 3.3.x stöder det. Appen bygger firmware med dina inställningar så att du kan flasha den från en PC med en STLink eller Betaflight passthrough.
- **Ladda ner binärfil.** Spara den byggda firmware-filen istället för att flasha den, för manuell flashning eller granskning.
- **Exportera ELRS Lua-skript.** Spara `elrs.lua` för EdgeTX- och OpenTX-radio.
- **Skicka felsökningsrapport.** Skicka enhetsinformation och apploggar för att hjälpa till att åtgärda en bugg. Binding phrases och Wi-Fi-lösenord inkluderas aldrig.

---

## Felsökning

**Dashboard kan inte hitta min enhet.** Se till att din telefon fortfarande är ansluten till enhetens Wi-Fi-nätverk; vissa telefoner lämnar nätverk som saknar internet. På Android behåller ELRS Mobile sin trafik på det Wi-Fi-nätverket även utan internet. Tryck på **Försök igen**, eller ange IP-adressen från kugghjulsikonen (`10.0.0.1` på enhetens egen hotspot).

**Jag kan inte ladda ner firmware.** Koppla bort från enhetens hotspot och använd ett nätverk med internet.

**Min enhet svarar inte efter en misslyckad flashning.** Håll BOOT-knappen intryckt medan du ansluter den via USB för att komma in i bootloader-läge, flasha sedan om med [ExpressLRS Web Flasher](https://expresslrs.org/flasher). Wi-Fi-kapabla enheter kan också återställas genom att hålla BOOT intryckt i 60 sekunder för att starta Wi-Fi-hotspoten. Skärmen för **Hjälp & Support** i appen innehåller dessa steg, en FAQ och länkar till ExpressLRS Discord.

**Mina profiler försvann efter uppdatering.** Att uppdatera direkt från v1.0.43 eller äldre till v1.0.45 eller nyare kan inte överföra sparade profiler, binding phrases och Wi-Fi-inställningar vid en lagringsuppgradering. Appen informerar dig en gång; ange dem igen i Inställningar.

Utvecklare kan verifiera firmware som ELRS Mobile bygger med [Firmware Validation Tools](/firmware-validation).
