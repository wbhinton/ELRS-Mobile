# Guide pas à pas

## Phase 1 : Mise en cache du micrologiciel
1.  **Connectez-vous à Internet :** Assurez-vous que votre téléphone est connecté à Internet (par exemple, au Wi-Fi domestique ou au réseau mobile).
2.  **Ouvrez le Gestionnaire de micrologiciels :** Accédez au Firmware Manager dans l'application.
3.  **Téléchargez la version :** Appuyez sur l'icône de téléchargement à côté de la version ExpressLRS souhaitée. Cela met en cache de manière sécurisée les cibles de micrologiciel et les définitions matérielles requises sur votre téléphone pour une utilisation 100 % hors ligne.

## Phase 2 : Connexion à votre appareil
1.  **Allumez l'appareil :** Allumez votre récepteur (RX) ou émetteur (TX) ExpressLRS.
2.  **Attendez le Hotspot :** Attendez que l'appareil passe en mode Wi-Fi Hotspot (indiqué par une LED clignotant rapidement).
3.  **Connectez-vous au Hotspot :** Connectez le Wi-Fi de votre téléphone au réseau `ExpressLRS RX` ou `ExpressLRS TX` en utilisant le mot de passe `expresslrs`.
*   **Remarque :** ELRS Mobile gère nativement le routage forcé, garantissant que votre téléphone ne repasse pas silencieusement en 5G/LTE.

## Phase 3 : Flashage du micrologiciel
1.  **Naviguez vers Flasher l'appareil :** Depuis le tableau de bord principal, sélectionnez **Flasher l'appareil**.
2.  **Sélection de la cible :** Utilisez les listes déroulantes en cascade pour sélectionner le fournisseur et la cible matérielle spécifique.
3.  **Sélection de la version :** Choisissez une version de micrologiciel disponible dans votre référentiel hors ligne.
4.  **Configuration :** Saisissez vos identifiants personnalisés. L'application conserve le WiFi SSID, le WiFi Password et la Binding Phrase dans le stockage local afin que vous n'ayez pas à les ressaisir.
5.  **Construire et Flasher :** Appuyez sur **FLASH**. Le système applique un patch au binaire avec vos identifiants locaux et le télécharge.
*   **Crucial :** Attendez toujours la confirmation de succès et que la LED de l'appareil reprenne son clignotement avant de débrancher !

---

# FAQ

## Ai-je besoin d'une connexion Internet ou d'un service cellulaire pour flasher le micrologiciel ?
Non. ELRS Mobile offre un **Flashage 100 % hors ligne**. Tant que vous avez précédemment téléchargé la version du micrologiciel via le Firmware Manager lorsque vous étiez connecté au Wi-Fi domestique, l'application peut assembler et flasher dynamiquement le micrologiciel entièrement hors ligne.

## Je reçois une erreur "Not enough space" lors du flashage de mon récepteur ESP8285.
Les puces ESP8285 (comme celles que l'on trouve sur de nombreuses cartes AIO) ne disposent que de 1 Mo de stockage physique total. La mise à jour directe vers une version majeure (comme de 3.x à 4.x) via Wi-Fi peut manquer d'espace de double partition car le fichier entrant est trop volumineux pour être décompressé en même temps que le micrologiciel actuellement en cours d'exécution.

**Comment résoudre :** D'abord, flashez votre récepteur vers une version intermédiaire (comme **3.6.3**). Une fois qu'il exécute le micrologiciel plus léger 3.6.3, vous aurez suffisamment d'espace de partition pour flasher avec succès vers votre cible 4.0 souhaitée. Alternativement, activez le **Mode Expert** dans les Paramètres, enregistrez le binaire construit localement et flashez-le manuellement via une connexion Betaflight Passthrough filaire.

## Où puis-je trouver le script Lua ExpressLRS pour ma radio ?
ELRS Mobile est livré avec le script Lua universel et agnostique en termes de version, intégré directement ! Pour l'obtenir :
1.  Allez dans **Paramètres** et activez le **Mode Expert**.
2.  Appuyez sur **Exporter le script Lua ELRS**.
3.  Cela enregistre `elrs.lua` directement dans le stockage local de votre téléphone. Allumez votre radio et branchez-la à votre téléphone via USB, assurez-vous de sélectionner le mode "USB Storage" sur votre radio et transférez le fichier dans votre dossier `SCRIPTS/TOOLS` à l'aide du gestionnaire de fichiers de votre téléphone.

**Remarque :** Vous devez supprimer toutes les versions précédentes du script elrs.lua (par exemple, elrs_v2.lua, elrs_v3.lua, etc.) de la carte SD de votre radio avant d'utiliser le nouveau script.

## Que faire si un flash échoue et que mon appareil ne répond plus ?
Si votre appareil ne répond plus après un flashage échoué, vous pouvez facilement le récupérer :
1.  Maintenez le bouton BOOT de l'appareil tout en le branchant via USB pour entrer en mode bootloader.
2.  Utilisez un ordinateur et le ELRS Web Flasher pour re-flasher l'appareil via une connexion USB/UART filaire.
3.  Pour les appareils compatibles Wi-Fi, vous pouvez également maintenir le bouton BOOT
**Remarque :** Il y a un lien vidéo sur l'onglet Ressources qui montre comment faire cela.

## Puis-je enregistrer le fichier de micrologiciel sur mon téléphone sans le flasher ?
Oui. En allant dans **Paramètres** et en activant le **Mode Expert**, vous débloquez la possibilité d'enregistrer le binaire du micrologiciel assemblé directement dans le stockage local de votre appareil mobile au lieu de le flasher immédiatement Over-The-Air (OTA).

Ceci est particulièrement utile si vous souhaitez flasher l'appareil manuellement à l'aide d'un programmeur matériel dédié (comme un adaptateur STLink ou FTDI).

## Je reçois une erreur "Target Mismatch". Que dois-je faire ?
Une erreur "Target Mismatch" se produit lorsque la cible matérielle que vous avez sélectionnée dans l'application ne correspond pas à la cible du micrologiciel actuellement exécuté sur l'appareil.

Actuellement, l'application ne prend pas en charge le flashage d'une cible différente de celle actuellement exécutée sur l'appareil.

<!-- source_hash: 32fdb222bf9c42513cbd49e51679ccaa -->