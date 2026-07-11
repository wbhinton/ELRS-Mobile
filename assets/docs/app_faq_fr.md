# Procédure

## Phase 1 : Mise en cache du firmware
1. **Connectez-vous à Internet :** Assurez-vous que votre téléphone est connecté à Internet (par exemple, Wi-Fi domestique ou réseau mobile).
2. **Ouvrez le gestionnaire de firmware :** Naviguez vers le gestionnaire de firmware dans l'application.
3. **Téléchargez la version :** Appuyez sur l'icône de téléchargement à côté de la version ExpressLRS souhaitée. Cela met en cache de manière sécurisée les cibles de firmware et les définitions matérielles requises sur votre téléphone pour une utilisation 100 % hors ligne.

## Phase 2 : Connexion à votre appareil
1. **Allumez l'appareil :** Allumez votre récepteur ExpressLRS (RX) ou émetteur (TX).
2. **Attendez le Hotspot :** Attendez que l'appareil entre en mode Hotspot Wi-Fi (indiqué par une LED clignotant rapidement).
3. **Connectez-vous au Hotspot :** Connectez le Wi-Fi de votre téléphone au réseau `ExpressLRS RX` ou `ExpressLRS TX` en utilisant le mot de passe `expresslrs`.
* **Note :** ELRS Mobile gère nativement le routage forcé, garantissant que votre téléphone ne bascule pas silencieusement vers la 5G/LTE.

## Phase 3 : Flashage du firmware
1. **Naviguez vers Flash Device :** Depuis le tableau de bord principal, sélectionnez **Flasher l'appareil**.
2. **Sélection de la cible :** Utilisez les listes déroulantes en cascade pour sélectionner le fournisseur et la cible matérielle spécifique.
3. **Sélection de la version :** Choisissez une version de firmware disponible depuis votre référentiel hors ligne.
4. **Configuration et profils :** Choisissez ou créez un **Profil de flashage** (par exemple, "Mes Quads", "Race Spec") pour charger vos identifiants personnalisés. L'application conserve le Wi-Fi SSID, le mot de passe Wi-Fi, la phrase de liaison, le domaine réglementaire et les intervalles d'activation automatique dans ces profils nommés afin que vous n'ayez pas à les ressaisir lorsque vous passez d'une configuration à l'autre.
5. **Construction et Flashage :** Appuyez sur **FLASH**. Le système patche le binaire avec vos identifiants locaux et le télécharge.
* **Crucial :** Attendez toujours la confirmation de succès et que la LED de l'appareil reprenne son clignotement avant de débrancher !

---

# FAQ

## Ai-je besoin d'une connexion internet ou d'un service cellulaire pour flasher le firmware ?
Non. ELRS Mobile propose le **Flashage 100 % hors ligne**. Tant que vous avez précédemment téléchargé la version du firmware via le gestionnaire de firmware en étant connecté au Wi-Fi domestique, l'application peut assembler et flasher dynamiquement le firmware entièrement hors ligne.

## Que sont les profils de flashage et comment les utiliser ?
Les profils de flashage vous permettent de sauvegarder et de basculer entre plusieurs configurations de flashage (par exemple, "Mes Quads", "Stock / Réinitialisation d'usine", "Race Spec"). Chaque profil stocke en toute sécurité sa propre phrase de liaison, Wi-Fi SSID, mot de passe Wi-Fi, domaines réglementaires et intervalle d'activation automatique du Wi-Fi.

Pour les utiliser :
1. Appuyez sur l'icône **+** (Ajouter) à côté de la liste déroulante "Profil de flashage" dans la carte **Options de configuration**.
2. Nommez votre nouveau profil et personnalisez les paramètres. Les modifications sont automatiquement sauvegardées instantanément.
3. Sélectionnez n'importe quel profil dans la liste déroulante pour échanger automatiquement tous les paramètres.
4. Pour supprimer un profil, sélectionnez-le et appuyez sur l'icône de la corbeille/suppression (vous devez avoir au moins deux profils pour en supprimer un).

## J'obtiens une erreur "Pas assez d'espace" lors du flashage de mon récepteur ESP8285.
Les puces ESP8285 (comme celles que l'on trouve sur de nombreuses cartes AIO) ne disposent que de 1 Mo de stockage physique total. La mise à jour directe vers une version majeure (comme de 3.x à 4.x) via Wi-Fi peut manquer d'espace de double-partition car le fichier entrant est trop volumineux pour être décompressé à côté du firmware actuellement en cours d'exécution.

**Comment réparer :** Tout d'abord, flashez votre récepteur vers une version intermédiaire (comme **3.6.3**). Une fois qu'il exécute le firmware 3.6.3 plus léger, vous aurez suffisamment d'espace de partition pour flasher avec succès votre cible 4.0 souhaitée. Alternativement, activez le **Mode Expert** dans les paramètres, enregistrez le binaire construit localement et flashez-le manuellement via une connexion filaire Betaflight Passthrough.

## Où puis-je trouver le script Lua ExpressLRS pour ma radio ?
ELRS Mobile est livré avec le script Lua universel et agnostique en matière de version intégré ! Pour l'obtenir :
1. Allez dans **Paramètres** et activez le **Mode Expert**.
2. Appuyez sur **Exporter le script Lua ELRS**.
3. Cela enregistre `elrs.lua` directement dans le stockage local de votre téléphone. Allumez votre radio et connectez-la à votre téléphone via USB, assurez-vous de sélectionner le mode "Stockage USB" sur votre radio et transférez le fichier dans votre dossier `SCRIPTS/TOOLS` à l'aide du gestionnaire de fichiers de votre téléphone.

**Note :** Vous devez supprimer toutes les versions précédentes du script elrs.lua (par exemple, elrs_v2.lua, elrs_v3.lua, etc.) de la carte SD de votre radio avant d'utiliser le nouveau script.

## Que faire si un flash échoue et que mon appareil ne répond plus ?
Si votre appareil ne répond plus après un flash échoué, vous pouvez facilement le récupérer :
1. Maintenez le bouton BOOT de l'appareil enfoncé tout en le branchant via USB pour entrer en mode bootloader.
2. Utilisez un ordinateur et le ELRS Web Flasher pour reflasher l'appareil via une connexion USB/UART filaire.
3. Pour les appareils compatibles Wi-Fi, vous pouvez également maintenir le bouton BOOT

**Note :** Il y a un lien vidéo sur l'onglet Ressources qui montre comment faire cela.

## Puis-je enregistrer le fichier firmware sur mon téléphone sans le flasher ?
Oui. En allant dans **Paramètres** et en activant le **Mode Expert**, vous débloquez la possibilité d'enregistrer le binaire de firmware assemblé directement sur le stockage local de votre appareil mobile au lieu de le flasher immédiatement Over-The-Air (OTA).

Ceci est particulièrement utile si vous souhaitez flasher l'appareil manuellement à l'aide d'un programmeur matériel dédié (comme un adaptateur STLink ou FTDI).

## J'obtiens une erreur "Incompatibilité de cible". Que dois-je faire ?
Une erreur d'incompatibilité de cible se produit lorsque la cible matérielle que vous avez sélectionnée dans l'application ne correspond pas à la cible du firmware actuellement exécuté sur l'appareil.

Pour éviter tout dommage accidentel, l'application vous avertira si une incompatibilité est détectée. Cependant, si vous êtes sûr que la cible sélectionnée est correcte (par exemple, si vous convertissez un appareil vers une variante de firmware différente ou corrigez un flash incorrect précédent), vous pouvez appuyer sur **FORCER LE FLASH** dans la boîte de dialogue d'incompatibilité pour outrepasser la vérification et procéder au flash.

<!-- source_hash: 4de4fb02852e8f160449fd60465b7888 -->