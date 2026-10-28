# Guida

## Fase 1: Memorizzazione nella cache del Firmware
1. **Connettiti a Internet:** Assicurati che il tuo telefono sia connesso a Internet (ad esempio, Wi-Fi domestico o rete mobile).
2. **Apri Gestione Firmware:** Vai alla Gestione Firmware nell'app.
3. **Scarica Release:** Tocca l'icona di download accanto alla release ExpressLRS desiderata. Questo memorizza in modo sicuro nella cache i target firmware e le definizioni hardware richieste sul tuo telefono per un utilizzo offline al 100%.

## Fase 2: Connessione al tuo Dispositivo
1. **Accendi il Dispositivo:** Accendi il tuo ricevitore (RX) o trasmettitore (TX) ExpressLRS.
2. **Attendi Hotspot:** Attendi che il dispositivo entri in Wi-Fi Hotspot Mode (indicato da un LED che lampeggia rapidamente).
3. **Connettiti all'Hotspot:** Collega il Wi-Fi del tuo telefono alla rete `ExpressLRS RX` o `ExpressLRS TX` usando la password `expresslrs`.
* **Nota:** ELRS Mobile gestisce nativamente il routing forzato, assicurando che il tuo telefono non torni silenziosamente a 5G/LTE.

## Fase 3: Flash del Firmware
1. **Vai a Flash Dispositivo:** Dalla Dashboard principale, seleziona **Flash Dispositivo**.
2. **Selezione Target:** Usa i menu a discesa a cascata per selezionare il vendor e lo specifico hardware target.
3. **Selezione Versione:** Scegli una versione firmware disponibile dal tuo repository offline.
4. **Configurazione e Profili:** Scegli o crea un **Flashing Profile** (ad esempio, "My Quads", "Race Spec") per caricare le tue credenziali personalizzate. L'applicazione memorizza persistentemente il Wi-Fi SSID, la Wi-Fi Password, la Binding Phrase, il Regulatory Domain e gli intervalli Auto-On in questi profili nominati, in modo da non doverli reinserire quando si passa da una configurazione all'altra.
5. **Build & Flash:** Tocca **FLASH**. Il sistema patcha il binary con le tue credenziali locali e lo carica.
* **Cruciale:** Attendi sempre la conferma di successo e che il LED del dispositivo riprenda a lampeggiare prima di scollegare!

---

# FAQ

## Ho bisogno di una connessione internet o di un servizio cellulare per flashare il firmware?
No. ELRS Mobile offre **100% Offline Flashing**. Purché tu abbia precedentemente scaricato la versione del firmware tramite il Firmware Manager mentre eri connesso al Wi-Fi domestico, l'app può assemblare e flashare dinamicamente il firmware completamente offline.

## Cosa sono i Flashing Profiles e come si usano?
I Flashing Profiles ti permettono di salvare e passare tra diverse configurazioni di flashing (ad esempio, "My Quads", "Stock / Factory Reset", "Race Spec"). Ogni profilo memorizza in modo sicuro la propria binding phrase, Wi-Fi SSID, Wi-Fi password, regulatory domains e Wi-Fi auto-on interval.

Per usarli:
1. Tocca l'icona **+** (Aggiungi) accanto al menu a discesa "Flashing Profile" nella scheda **Configuration Options**.
2. Nomina il tuo nuovo profilo e personalizza le impostazioni. Le modifiche vengono salvate automaticamente all'istante.
3. Seleziona qualsiasi profilo dal menu a discesa per scambiare automaticamente tutti i parametri.
4. Per eliminare un profilo, selezionalo e tocca l'icona del cestino/elimina (devi avere almeno due profili per poterne eliminare uno).

## Ricevo un errore "Not enough space" quando flasho il mio ricevitore ESP8285.
I chip ESP8285 (come quelli che si trovano su molte AIO boards) hanno solo 1MB di spazio di archiviazione fisico totale. L'aggiornamento diretto a una major release (come da 3.x a 4.x) tramite Wi-Fi può esaurire lo spazio della doppia partizione perché il file in arrivo è troppo grande per essere scompattato accanto al firmware attualmente in esecuzione.

**Come risolvere:** Per prima cosa, flasha il tuo ricevitore a una versione intermedia (come **3.6.3**). Una volta che sta eseguendo il firmware 3.6.3 più leggero, avrai abbastanza spazio di partizione per flashare con successo al tuo target 4.0 desiderato. In alternativa, abilita **Expert Mode** in Impostazioni, salva il binary costruito localmente e flashalo manualmente tramite una connessione Betaflight Passthrough cablata.

## Dove trovo lo script ExpressLRS Lua per la mia radio?
ELRS Mobile include lo script Lua universale e indipendente dalla versione! Per ottenerlo:
1. Vai su **Impostazioni** e attiva **Expert Mode**.
2. Tocca **Esporta ELRS Lua Script**.
3. Questo salva `elrs.lua` direttamente nella memoria locale del tuo telefono. Accendi la tua radio e collegala al telefono tramite USB, assicurati di selezionare la modalità "USB Storage" sulla tua radio e trasferisci il file nella tua cartella `SCRIPTS/TOOLS` usando il gestore file del tuo telefono.

**Nota:** Devi eliminare tutte le versioni precedenti dello script elrs.lua (ad esempio, elrs_v2.lua, elrs_v3.lua, ecc.) dalla SD card della tua radio prima di usare il nuovo script.

## Cosa succede se un flash fallisce e il mio dispositivo diventa non responsivo?
Se il tuo dispositivo non risponde dopo un flash fallito, puoi facilmente recuperarlo:
1. Tieni premuto il BOOT button sul dispositivo mentre lo colleghi tramite USB per entrare in modalità bootloader.
2. Usa un computer e l'ELRS Web Flasher per riflashare il dispositivo tramite una connessione USB/UART cablata.
3. Per i dispositivi con capacità Wi-Fi, puoi anche tenere premuto il BOOT

**Nota:** C'è un link video nella scheda Risorse che mostra come farlo.

## Posso salvare il file firmware sul mio telefono senza flasharlo?
Sì. Andando su **Impostazioni** e abilitando **Expert Mode**, sblocchi la possibilità di salvare il binary del firmware assemblato direttamente nella memoria locale del tuo dispositivo mobile invece di flasharlo immediatamente Over-The-Air (OTA).

Questo è particolarmente utile se desideri flashare il dispositivo manualmente utilizzando un programmatore hardware dedicato (come un STLink o un FTDI adapter).

## Ricevo un errore "Target Mismatch". Cosa devo fare?
Un errore di target mismatch si verifica quando l'hardware target selezionato nell'app non corrisponde al target del firmware attualmente in esecuzione sul dispositivo.

Per prevenire danni accidentali, l'app ti avviserà se viene rilevata una discrepanza. Tuttavia, se sei sicuro che il target selezionato sia corretto (ad esempio, se stai convertendo un dispositivo a una diversa variante di firmware o correggendo un flash precedente errato), puoi toccare **FORCE FLASH** nella finestra di dialogo di mismatch per ignorare il controllo e procedere con il flash.

<!-- source_hash: 4de4fb02852e8f160449fd60465b7888 -->