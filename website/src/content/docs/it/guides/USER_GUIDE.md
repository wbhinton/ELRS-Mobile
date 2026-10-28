---
title: "Guida Utente"
slug: it/user_guide
sidebar:
  order: 1
---

ELRS Mobile flasha e configura i ricevitori (RX) e i trasmettitori (TX) ExpressLRS dal tuo telefono, tramite Wi-Fi, senza laptop e senza connessione internet sul campo. Funziona con hardware basato su ESP (ESP8285, ESP32, ESP32-C3, ESP32-S3) e firmware ExpressLRS 3.3.x e 4.x. Vedi [Hardware supportato](/supported_hardware) per ogni dispositivo compatibile.

Il flusso di lavoro si divide in due parti: scarica il firmware quando hai internet, quindi flasha ovunque.

---

## Installazione

| Piattaforma | Dove trovarlo |
| :--- | :--- |
| Android | [Google Play](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile) |
| iPhone e iPad | [App Store](https://apps.apple.com/us/app/elrs-mobile/id6760490014) |
| Android, senza Google Play | [Download diretto APK](https://cdn.elrsmobile.com/ELRS-Mobile-latest.apk), [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases), o [GitHub Store](https://github.com/OpenHub-Store/Github-Store) |

Le versioni dello store si aggiornano tramite Google Play e l'App Store. L'APK scaricato direttamente controlla la disponibilità di nuove versioni una volta al giorno e offre di scaricarle; puoi anche controllare in qualsiasi momento da **Impostazioni → Info e Legale → Controlla aggiornamenti**, saltare una versione o ricevere un promemoria più tardi. Le tue impostazioni e i tuoi profili vengono mantenuti quando installi un aggiornamento.

Vuoi nuove funzionalità in anticipo? Unisciti alla [beta di Google Play](https://play.google.com/apps/testing/io.datarx.elrsmobile) o alla [beta di TestFlight](https://testflight.apple.com/join/jwU1WrpX).

Al primo avvio l'app mostra un breve disclaimer. Il flashing del firmware comporta sempre dei rischi per il tuo hardware; accetta per continuare.

---

## Guida rapida: flashare il tuo primo dispositivo

### Passaggio 1: Scarica il firmware (a casa)

1. Sulla Dashboard, apri **Firmware Manager**.
2. Tocca l'icona di download accanto alla versione ExpressLRS desiderata. Sono elencate solo le versioni 3.3.0 e successive: sono le prime con il firmware unificato su cui si basa ELRS Mobile.
3. Al termine del download, la versione mostra **Pronto per l'uso offline**. Il firmware e le definizioni hardware di cui ha bisogno sono ora memorizzati sul tuo telefono.

Scarica il firmware tramite il tuo Wi-Fi domestico o i dati mobili. Non puoi scaricare mentre il telefono è connesso all'hotspot Wi-Fi di un ricevitore o trasmettitore, perché quella rete non ha internet.

L'intestazione mostra quante versioni hai memorizzato rispetto al tuo limite. Cambia il limite in **Impostazioni → App e Archiviazione → Max Versioni Cache**, ed elimina le versioni che non ti servono più.

### Passaggio 2: Connettiti al tuo dispositivo

1. Accendi il tuo ricevitore o trasmettitore e attendi che avvii il suo hotspot Wi-Fi. Per impostazione predefinita questo avviene 60 secondi dopo l'accensione se non si è connesso al suo partner. I trasmettitori possono anche avviare il Wi-Fi dallo script Lua ExpressLRS sulla tua radio.
2. Sul tuo telefono, connettiti alla rete **ExpressLRS RX** o **ExpressLRS TX**. La password è `expresslrs`.
3. Apri ELRS Mobile. La Dashboard trova automaticamente il dispositivo e mostra il suo nome prodotto, versione firmware, target e dominio normativo.

Se la Dashboard mostra **Nessun dispositivo trovato**, tocca **Riprova**. Se il tuo dispositivo si trova su una rete diversa (ad esempio, connesso al tuo Wi-Fi domestico), tocca l'icona dell'ingranaggio sulla scheda del dispositivo e inserisci il suo indirizzo IP.

Anche i dispositivi con firmware precedente alla versione 3.1 vengono rilevati, così puoi aggiornarli a una versione corrente.

### Passaggio 3: Flasha

1. Sulla Dashboard, tocca **Flasha Dispositivo**.
2. Controlla il target. L'app preseleziona il target che corrisponde al dispositivo connesso quando possibile; altrimenti scegli Tipo di dispositivo, Fornitore del dispositivo, Regolamentazione e Frequenza e Target del dispositivo.
3. Scegli la versione del firmware. Le versioni che hai scaricato sono contrassegnate come **(Cached)**. Se l'hardware richiede una versione più recente di quella che hai, l'app te lo indicherà e ti offrirà di scaricarne una compatibile.
4. Controlla le opzioni del firmware: profilo di flashing, binding phrase, rete Wi-Fi e password, dominio normativo e intervallo di attivazione automatica del Wi-Fi.
5. Tocca **Flash**.

La barra di avanzamento segue ogni passaggio: individuazione e decompressione del firmware scaricato, compilazione con le tue impostazioni, caricamento e **Scrittura sul dispositivo — Attendere prego** mentre il dispositivo lo installa e si riavvia. Quando il dispositivo conferma, vedrai **Flashing riuscito! Il dispositivo si sta riavviando**, e la Dashboard si ricollegherà una volta che sarà di nuovo operativo.

---

## Controlli di sicurezza

L'app controlla le tue scelte prima del flashing e si ferma se qualcosa non sembra corretto.

:::danger[Chip incompatibile]
Il firmware per un chip non può mai essere eseguito su un altro (ad esempio, firmware ESP32 su un ricevitore ESP8285). L'app blocca il flashing e ti dice quale chip è ciascuno. Scegli un target per il chip del tuo dispositivo.
:::

:::caution[Mancanza di corrispondenza del target]
Se il target selezionato non corrisponde al prodotto segnalato dal dispositivo, vedrai **Target Mismatch**. Controlla prima la tua selezione. Se sei sicuro che sia corretto (ad esempio, in caso di recupero da un flash non riuscito o di passaggio a una definizione di target più recente), tocca **Force Flash**.
:::

:::note[Nessuna binding phrase]
Il flashing senza una binding phrase funziona, ma il dispositivo si collegherà solo utilizzando la frase predefinita (vuota). L'app chiede prima di continuare.
:::

:::caution[Flash non confermato]
Se il dispositivo si disconnette prima di confermare il flash (ha perso alimentazione, si è riavviato o la connessione Wi-Fi è caduta), l'app non può stabilire se l'aggiornamento è terminato. Mostra un avviso ambra invece di segnalare il successo. Riconnettiti e controlla la versione del firmware sulla Dashboard; se non è cambiata, flasha di nuovo.
:::

---

## Profili di flashing

Un profilo di flashing salva una binding phrase, la rete Wi-Fi domestica e la password, i domini normativi predefiniti e l'intervallo di attivazione automatica del Wi-Fi sotto un nome. Usane uno per flotta o configurazione radio, e passa da uno all'altro con un solo tocco.

Gestisci i profili in **Impostazioni → Profili e Rete**:

- **Aggiungi:** tocca **+**, digita un nome e tocca **Aggiungi**.
- **Cambia:** scegli un profilo dall'elenco **Profilo di Flashing**. È disponibile anche nella schermata di flashing.
- **Modifica:** cambia qualsiasi campo; il profilo attivo si salva automaticamente.
- **Elimina:** seleziona il profilo e tocca l'icona di eliminazione. Manti sempre almeno un profilo.

Le binding phrase e le password Wi-Fi sono memorizzate nell'archiviazione sicura crittografata del tuo telefono.

---

## Configurazione del dispositivo

Sulla Dashboard, tocca **Configurazione Dispositivo** per aprire la pagina delle impostazioni ExpressLRS del dispositivo connesso all'interno dell'app. Usala per modificare le impostazioni Wi-Fi e di binding, l'abbinamento del modello, il protocollo seriale, la mappatura dell'output PWM e altre opzioni del dispositivo. L'app mantiene la pagina bloccata al tuo dispositivo.

---

## Impostazioni

| Sezione | Contenuto |
| :--- | :--- |
| Profili e Rete | Profili di flashing, binding phrase, rete Wi-Fi domestica e password, domini normativi predefiniti 2.4 GHz e sub-GHz |
| App e Archiviazione | Max versioni cache, Firmware Manager, pulisci la cache del firmware, lingua dell'app, analisi anonime sull'utilizzo (attive per impostazione predefinita; disattiva con **Condividi Analisi**) |
| Avanzate e Debug | Modalità Esperto e i suoi strumenti (sotto) |
| Info e Legale | Versione dell'app, note legali e licenza, supporta lo sviluppo e **Controlla aggiornamenti** nell'APK a download diretto |

Cambia la lingua dell'app da Impostazioni o dal pulsante lingua nella barra superiore. ELRS Mobile è disponibile in 18 lingue.

---

## Modalità Esperto

Attiva **Impostazioni → Avanzate e Debug → Modalità Esperto** per sbloccare:

- **Target STM32.** L'hardware più vecchio basato su STM32 non può essere flashato tramite Wi-Fi, e solo ExpressLRS 3.3.x lo supporta. L'app compila il firmware con le tue impostazioni in modo da poterlo flashare da un PC con un STLink o passthrough Betaflight.
- **Scarica binario.** Salva il file del firmware compilato invece di flasharlo, per il flashing manuale o la verifica.
- **Esporta script Lua ELRS.** Salva `elrs.lua` per radio EdgeTX e OpenTX.
- **Invia rapporto di debug.** Invia informazioni sul dispositivo e log dell'app per aiutare a risolvere un bug. Le binding phrase e le password Wi-Fi non sono mai incluse.

---

## Risoluzione dei problemi

**La Dashboard non riesce a trovare il mio dispositivo.** Assicurati che il tuo telefono sia ancora connesso alla rete Wi-Fi del dispositivo; alcuni telefoni abbandonano le reti che non hanno internet. Su Android, ELRS Mobile mantiene il suo traffico su quella rete Wi-Fi anche senza internet. Tocca **Riprova**, o inserisci l'indirizzo IP dall'icona dell'ingranaggio (`10.0.0.1` sull'hotspot del dispositivo).

**Non riesco a scaricare il firmware.** Disconnettiti dall'hotspot del dispositivo e usa una rete con internet.

**Il mio dispositivo non risponde dopo un flash fallito.** Tieni premuto il pulsante BOOT mentre lo colleghi tramite USB per entrare in modalità bootloader, quindi flasha di nuovo con il [ExpressLRS Web Flasher](https://expresslrs.org/flasher). I dispositivi con capacità Wi-Fi possono anche essere recuperati tenendo premuto BOOT per 60 secondi per avviare l'hotspot Wi-Fi. La schermata **Aiuto e Supporto** all'interno dell'app contiene questi passaggi, una FAQ e collegamenti al Discord di ExpressLRS.

**I miei profili sono scomparsi dopo l'aggiornamento.** L'aggiornamento diretto dalla v1.0.43 o precedente alla v1.0.45 o successiva non può trasferire profili salvati, binding phrase e impostazioni Wi-Fi attraverso un aggiornamento dell'archiviazione. L'app te lo comunica una volta; reinseriscili in Impostazioni.

---

Gli sviluppatori possono verificare il firmware che ELRS Mobile compila con gli [Strumenti di Convalida del Firmware](/firmware-validation).

<!-- source_hash: 927017dfd36d96b7c787e4972528233d -->