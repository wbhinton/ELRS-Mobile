# Guida

## Fase 1: Caching del firmware
1. **Connettiti a Internet:** Assicurati che il tuo telefono sia connesso a Internet (es. Wi-Fi di casa o rete mobile).
2. **Apri Firmware Manager:** Naviga su Firmware Manager nell'app.
3. **Scarica la release:** Tocca l'icona di download accanto alla release ExpressLRS desiderata. Questo memorizza in modo sicuro nella cache i target del firmware richiesti e le definizioni hardware sul tuo telefono per un utilizzo completamente offline.

## Fase 2: Connessione al tuo dispositivo
1. **Accendi il dispositivo:** Accendi il tuo ricevitore ExpressLRS (RX) o trasmettitore (TX).
2. **Attendi l'hotspot:** Attendi che il dispositivo entri in modalità Wi-Fi Hotspot (indicato da un LED che lampeggia rapidamente).
3. **Connettiti all'hotspot:** Connetti il Wi-Fi del tuo telefono alla rete `ExpressLRS RX` o `ExpressLRS TX` usando la password `expresslrs`.
* **Nota:** ELRS Mobile gestisce nativamente il routing forzato, assicurando che il telefono non passi silenziosamente al 5G/LTE.

## Fase 3: Flash del firmware
1. **Naviga su Flash Device:** Dalla Dashboard principale, seleziona **Flash Device**.
2. **Selezione del target:** Utilizza i menu a discesa a cascata per selezionare il fornitore e lo specifico target hardware.
3. **Selezione della versione:** Scegli una versione firmware disponibile dal tuo repository offline.
4. **Configurazione e Profili:** Scegli o crea un **Flashing Profile** (es. "My Quads", "Race Spec") per caricare le tue credenziali personalizzate. L'applicazione mantiene il Wi-Fi SSID, la Password Wi-Fi, la Binding Phrase, il Dominio Regolatorio e gli intervalli di Auto-On in questi profili nominati, così non devi reinserirli quando passi tra diverse configurazioni.
5. **Crea e Flash:** Tocca **FLASH**. Il sistema patcha il binario con le tue credenziali locali e lo carica.
* **Cruciale:** Attendere sempre la conferma di successo e che il LED del dispositivo riprenda a lampeggiare prima di scollegare!

---

# Domande Frequenti

## Ho bisogno di una connessione internet o di un servizio cellulare per flashare il firmware?
No. ELRS Mobile offre il **Flashing 100% Offline**. Purché tu abbia precedentemente scaricato la versione del firmware tramite il Firmware Manager mentre eri connesso al Wi-Fi di casa, l'app può assemblare e flashare dinamicamente il firmware completamente offline.

## Cosa sono i Flashing Profile e come li uso?
I Flashing Profile ti permettono di salvare e passare tra diverse configurazioni di flashing (es. "My Quads", "Stock / Factory Reset", "Race Spec"). Ogni profilo memorizza in modo sicuro la propria binding phrase, Wi-Fi SSID, password Wi-Fi, domini regolatori e intervallo di auto-accensione Wi-Fi.

Per usarli:
1. Tocca l'icona **+** (Aggiungi) accanto al menu a discesa "Flashing Profile" nella scheda **Configuration Options**.
2. Nomina il tuo nuovo profilo e personalizza le impostazioni. Le modifiche vengono salvate automaticamente all'istante.
3. Seleziona qualsiasi profilo dal menu a discesa per scambiare automaticamente tutti i parametri.
4. Per eliminare un profilo, selezionalo e tocca l'icona cestino/elimina (devi avere almeno due profili per poterne eliminare uno).

## Ricevo un errore "Not enough space" quando flasho il mio ricevitore ESP8285.
I chip ESP8285 (come quelli che si trovano su molte schede AIO) hanno solo 1MB di memoria fisica totale. L'aggiornamento diretto a una major release (come da 3.x a 4.x) tramite Wi-Fi può esaurire lo spazio a doppia partizione perch�� il file in arrivo è troppo grande per essere decompresso insieme al firmware attualmente in esecuzione.

**Come risolvere:** Per prima cosa, flasha il tuo ricevitore a una versione intermedia (come la **3.6.3**). Una volta che sta eseguendo il firmware 3.6.3 più leggero, avrai spazio sufficiente nella partizione per flashare con successo al tuo target 4.0 desiderato. In alternativa, abilita la **Modalità Esperto** nelle Impostazioni, salva il binario costruito localmente e flashalo manualmente tramite una connessione Betaflight Passthrough cablata.

## Dove trovo lo script ExpressLRS Lua per la mia radio?
ELRS Mobile include lo script Lua universale e indipendente dalla versione! Per ottenerlo:
1. Vai su **Settings** e attiva la **Modalità Esperto**.
2. Tocca **Export ELRS Lua Script**.
3. Questo salva `elrs.lua` direttamente nella memoria locale del tuo telefono. Accendi la tua radio e collegala al telefono tramite USB, assicurati di selezionare la modalità "USB Storage" sulla tua radio e trasferisci il file nella cartella `SCRIPTS/TOOLS` usando il gestore file del tuo telefono.

**Nota:** Devi eliminare qualsiasi versione precedente dello script elrs.lua (es. elrs_v2.lua, elrs_v3.lua, ecc.) dalla scheda SD della tua radio prima di utilizzare il nuovo script.

## Cosa succede se un flash fallisce e il mio dispositivo diventa non responsivo?
Se il tuo dispositivo non è responsivo dopo un flash fallito, puoi recuperarlo facilmente:
1. Tieni premuto il BOOT button sul dispositivo mentre lo colleghi via USB per entrare in modalità bootloader.
2. Usa un computer e l'ELRS Web Flasher per riflashare il dispositivo tramite una connessione USB/UART cablata.
3. Per i dispositivi con Wi-Fi, puoi anche tenere premuto il BOOT

**Nota:** C'è un link video nella scheda Risorse che mostra come farlo.

## Posso salvare il file del firmware sul mio telefono senza flasharlo?
Sì. Andando in **Settings** e abilitando la **Modalità Esperto**, sblocchi la capacità di salvare il binario del firmware assemblato direttamente nella memoria locale del tuo dispositivo mobile invece di flasharlo immediatamente Over-The-Air (OTA).

Questo è particolarmente utile se desideri flashare il dispositivo manualmente utilizzando un programmatore hardware dedicato (come un adattatore STLink o FTDI).

## Ricevo un errore "Target Mismatch". Cosa devo fare?
Un errore di "Target Mismatch" si verifica quando il target hardware selezionato nell'app non corrisponde al target del firmware attualmente in esecuzione sul dispositivo.

Per prevenire danni accidentali, l'app ti avviserà se viene rilevata una mancata corrispondenza. Tuttavia, se sei sicuro che il target selezionato sia corretto (ad esempio, se stai convertendo un dispositivo a una diversa variante firmware o correggendo un precedente flash errato), puoi toccare **FORCE FLASH** nella finestra di dialogo di mancata corrispondenza per ignorare il controllo e procedere con il flash.

<!-- source_hash: 4de4fb02852e8f160449fd60465b7888 -->