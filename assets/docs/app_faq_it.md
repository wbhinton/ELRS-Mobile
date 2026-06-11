# Guida

## Fase 1: Memorizzazione nella cache del Firmware
1. **Connettiti a Internet:** Assicurati che il tuo telefono sia connesso a Internet (es. Wi-Fi domestico o rete mobile).
2. **Apri il Gestore Firmware:** Vai al Gestore Firmware nell'app.
3. **Scarica la Release:** Tocca l'icona di download accanto alla release ExpressLRS desiderata. Questo memorizza in modo sicuro nella cache del telefono i target firmware e le definizioni hardware richieste per un utilizzo offline al 100%.

## Fase 2: Connessione al tuo dispositivo
1. **Accendi il dispositivo:** Accendi il tuo ricevitore (RX) o trasmettitore (TX) ExpressLRS.
2. **Attendi l'Hotspot:** Attendi che il dispositivo entri in modalità Wi-Fi Hotspot (indicato da un LED che lampeggia rapidamente).
3. **Connettiti all'Hotspot:** Connetti il Wi-Fi del tuo telefono alla rete `ExpressLRS RX` o `ExpressLRS TX` usando la password `expresslrs`.
* **Nota:** ELRS Mobile gestisce nativamente il routing forzato, assicurando che il tuo telefono non torni silenziosamente a 5G/LTE.

## Fase 3: Flash del Firmware
1. **Vai a Flash Device:** Dalla Dashboard principale, seleziona **Flash Device**.
2. **Selezione del Target:** Usa i menu a cascata per selezionare il venditore e lo specifico target hardware.
3. **Selezione della Versione:** Scegli una versione firmware disponibile dal tuo repository offline.
4. **Configurazione:** Inserisci le tue credenziali personalizzate. L'applicazione mantiene il WiFi SSID, la WiFi Password e la Binding Phrase nella memoria locale in modo da non doverli reinserire.
5. **Costruisci e Flash:** Tocca **FLASH**. Il sistema patcha il binario con le tue credenziali locali e lo carica.
* **Cruciale:** Attendi sempre la conferma di successo e che il LED del dispositivo riprenda a lampeggiare prima di scollegare!

---

# Domande Frequenti

## Ho bisogno di una connessione internet o di un servizio cellulare per flashare il firmware?
No. ELRS Mobile offre **Flash Offline al 100%**. Purché tu abbia precedentemente scaricato la versione del firmware tramite il Gestore Firmware mentre eri connesso al Wi-Fi di casa, l'app può assemblare e flashare dinamicamente il firmware completamente offline.

## Ricevo un errore "Spazio insufficiente" quando flasho il mio ricevitore ESP8285.
I chip ESP8285 (come quelli che si trovano su molte schede AIO) hanno solo 1MB di spazio di archiviazione fisico totale. L'aggiornamento diretto a una major release (come da 3.x a 4.x) tramite Wi-Fi può esaurire lo spazio della doppia partizione perché il file in arrivo è troppo grande per essere decompresso insieme al firmware attualmente in esecuzione. 

**Come risolvere:** Innanzitutto, flasha il tuo ricevitore a una versione intermedia (come la **3.6.3**). Una volta che sta eseguendo il firmware 3.6.3 più leggero, avrai abbastanza spazio nella partizione per flashare con successo al tuo target 4.0 desiderato. In alternativa, abilita la **Modalità Esperto** nelle Impostazioni, salva il binario costruito localmente e flashalo manualmente tramite una connessione cablata Betaflight Passthrough.

## Dove trovo lo script ExpressLRS Lua per la mia radio?
ELRS Mobile include lo script Lua universale e indipendente dalla versione integrato! Per ottenerlo:
1. Vai a **Impostazioni** e attiva la **Modalità Esperto**.
2. Tocca **Esporta Script ELRS Lua**.
3. Questo salva `elrs.lua` direttamente nella memoria locale del tuo telefono. Accendi la tua radio e collegala al telefono tramite USB, assicurati di selezionare la modalità "Archiviazione USB" sulla tua radio e trasferisci il file nella tua cartella `SCRIPTS/TOOLS` usando il file manager del tuo telefono. 

**Nota:** Devi eliminare qualsiasi versione precedente dello script elrs.lua (es. elrs_v2.lua, elrs_v3.lua, ecc.) dalla scheda SD della tua radio prima di usare il nuovo script.

## Cosa succede se un flash fallisce e il mio dispositivo diventa non responsivo?
Se il tuo dispositivo non risponde dopo un flash fallito, puoi facilmente recuperarlo:
1. Tieni premuto il pulsante BOOT sul dispositivo mentre lo colleghi tramite USB per entrare in modalità bootloader.
2. Usa un computer e l'ELRS Web Flasher per riflashare il dispositivo tramite una connessione cablata USB/UART.
3. Per i dispositivi abilitati al Wi-Fi, puoi anche tenere premuto il BOOT 

**Nota:** C'è un link video nella scheda Risorse che mostra come fare.

## Posso salvare il file del firmware sul mio telefono senza flasharlo?
Sì. Andando in **Impostazioni** e abilitando la **Modalità Esperto**, sblocchi la possibilità di salvare il binario del firmware assemblato direttamente nella memoria locale del tuo dispositivo mobile invece di flasharlo immediatamente Over-The-Air (OTA).

Questo è particolarmente utile se vuoi flashare il dispositivo manualmente usando un programmatore hardware dedicato (come un adattatore STLink o FTDI).

## Ricevo un errore "Target Mismatch". Cosa devo fare?
Un errore di target mismatch si verifica quando il target hardware selezionato nell'app non corrisponde al target del firmware attualmente in esecuzione sul dispositivo.

Attualmente l'app non supporta il flash di un target diverso da quello attualmente in esecuzione sul dispositivo.

<!-- source_hash: 32fdb222bf9c42513cbd49e51679ccaa -->