---
title: "Guide de l'utilisateur"
slug: fr/user_guide
sidebar:
  order: 1
---

ELRS Mobile flashe et configure les récepteurs (RX) et les émetteurs (TX) ExpressLRS depuis votre téléphone, via Wi-Fi, sans ordinateur portable et sans connexion internet sur le terrain. Il fonctionne avec le matériel basé sur ESP (ESP8285, ESP32, ESP32-C3, ESP32-S3) et les firmwares ExpressLRS 3.3.x et 4.x. Voir [Matériel pris en charge](/supported_hardware) pour chaque appareil compatible.

Le processus se déroule en deux étapes : téléchargez le firmware lorsque vous avez internet, puis flashez n'importe où.

---

## Installation

| Plateforme | Où le trouver |
| :--- | :--- |
| Android | [Google Play](https://play.google.com/store/apps/details?id=io.datarx.elrsmobile) |
| iPhone et iPad | [App Store](https://apps.apple.com/us/app/elrs-mobile/id6760490014) |
| Android, sans Google Play | [Téléchargement direct de l'APK](https://cdn.elrsmobile.com/ELRS-Mobile-latest.apk), [GitHub Releases](https://github.com/wbhinton/ELRS-Mobile/releases), ou [GitHub Store](https://github.com/OpenHub-Store/Github-Store) |

Les versions des stores se mettent à jour via Google Play et l'App Store. L'APK en téléchargement direct vérifie la présence d'une nouvelle version une fois par jour et propose de la télécharger ; vous pouvez également vérifier à tout moment depuis **Paramètres → À propos et légal → Vérifier les mises à jour**, ignorer une version ou être rappelé plus tard. Vos paramètres et profils sont conservés lorsque vous installez une mise à jour.

Vous voulez les nouvelles fonctionnalités en avance ? Rejoignez la [bêta de Google Play](https://play.google.com/apps/testing/io.datarx.elrsmobile) ou la [bêta de TestFlight](https://testflight.apple.com/join/jwU1WrpX).

Au premier lancement, l'application affiche une courte clause de non-responsabilité. Flasher un firmware comporte toujours un certain risque pour votre matériel ; acceptez pour continuer.

---

## Démarrage rapide : flasher votre premier appareil

### Étape 1 : Télécharger le firmware (à la maison)

1. Sur le Dashboard, ouvrez **Gestionnaire de firmware**.
2. Appuyez sur l'icône de téléchargement à côté de la version ExpressLRS que vous souhaitez. Seules les versions 3.3.0 et plus récentes sont listées : ce sont les premières avec le firmware unifié sur lequel ELRS Mobile s'appuie.
3. Lorsque le téléchargement est terminé, la version affiche **Prêt pour une utilisation hors ligne**. Le firmware et les définitions matérielles dont il a besoin sont maintenant stockés sur votre téléphone.

Téléchargez le firmware via votre réseau Wi-Fi domestique ou vos données mobiles. Vous ne pouvez pas télécharger tant que votre téléphone est connecté au hotspot Wi-Fi d'un récepteur ou d'un émetteur, car ce réseau n'a pas d'internet.

L'en-tête indique le nombre de versions que vous avez stockées par rapport à votre limite. Modifiez la limite dans **Paramètres → Application et stockage → Max. de versions en cache**, et supprimez les versions dont vous n'avez plus besoin.

### Étape 2 : Connectez-vous à votre appareil

1. Allumez votre récepteur ou émetteur et attendez qu'il démarre son hotspot Wi-Fi. Par défaut, cela se produit 60 secondes après la mise sous tension s'il ne s'est pas connecté à son partenaire. Les émetteurs peuvent également démarrer le Wi-Fi à partir du script Lua ExpressLRS sur votre radio.
2. Sur votre téléphone, rejoignez le réseau **ExpressLRS RX** ou **ExpressLRS TX**. Le mot de passe est `expresslrs`.
3. Ouvrez ELRS Mobile. Le Dashboard trouve l'appareil automatiquement et affiche son nom de produit, sa version de firmware, sa cible et son domaine réglementaire.

Si le Dashboard affiche **Aucun appareil trouvé**, appuyez sur **Réessayer**. Si votre appareil est sur un réseau différent (par exemple, connecté à votre Wi-Fi domestique), appuyez sur l'icône d'engrenage sur la carte de l'appareil et entrez son adresse IP.

Les appareils exécutant un firmware antérieur à 3.1 sont également détectés, ce qui vous permet de les mettre à jour vers une version actuelle.

### Étape 3 : Flasher

1. Sur le Dashboard, appuyez sur **Flasher l'appareil**.
2. Vérifiez la cible. L'application présélectionne la cible qui correspond à l'appareil connecté lorsque c'est possible ; sinon, choisissez Type d'appareil, Fabricant de l'appareil, Réglementation et fréquence, et Cible de l'appareil.
3. Choisissez la version du firmware. Les versions que vous avez téléchargées sont marquées **(Mise en cache)**. Si le matériel nécessite une version plus récente que celle que vous avez, l'application vous en informe et propose de télécharger une version compatible.
4. Vérifiez les options du firmware : profil de flashage, phrase de liaison, réseau Wi-Fi et mot de passe, domaine réglementaire et intervalle d'activation automatique du Wi-Fi.
5. Appuyez sur **Flasher**.

La barre de progression suit chaque étape : localisation et décompression de votre firmware téléchargé, compilation avec vos paramètres, téléchargement, et **Écriture sur l'appareil — Veuillez patienter** pendant que l'appareil l'installe et redémarre. Lorsque l'appareil confirme, vous verrez **Flashage réussi ! L'appareil redémarre**, et le Dashboard se reconnecte une fois qu'il est de nouveau opérationnel.

---

## Vérifications de sécurité

L'application vérifie vos choix avant de flasher et s'arrête si quelque chose semble incorrect.

:::danger[Puce incompatible]
Un firmware conçu pour une puce ne peut jamais fonctionner sur une autre (par exemple, un firmware ESP32 sur un récepteur ESP8285). L'application bloque le flashage et vous indique de quelle puce il s'agit. Choisissez une cible pour la puce de votre appareil.
:::

:::caution[Cible incompatible]
Si la cible sélectionnée ne correspond pas au produit signalé par l'appareil, vous verrez **Cible incompatible**. Vérifiez d'abord votre sélection. Si vous êtes sûr que c'est correct (par exemple, pour récupérer après un mauvais flashage ou passer à une définition de cible plus récente), appuyez sur **Forcer le flashage**.
:::

:::note[Pas de phrase de liaison]
Le flashage sans phrase de liaison fonctionne, mais l'appareil ne se liera qu'en utilisant la phrase par défaut (vide). L'application vous demandera avant de continuer.
:::

:::caution[Flash non confirmé]
Si l'appareil se déconnecte avant de confirmer le flashage (il a perdu l'alimentation, a redémarré ou la connexion Wi-Fi a été interrompue), l'application ne peut pas savoir si la mise à jour est terminée. Elle affiche un avertissement orange au lieu de signaler le succès. Reconnectez-vous et vérifiez la version du firmware sur le Dashboard ; si elle n'a pas changé, flashez à nouveau.
:::

---

## Profils de flashage

Un profil de flashage enregistre une phrase de liaison, le réseau Wi-Fi domestique et son mot de passe, les domaines réglementaires par défaut, et l'intervalle d'activation automatique du Wi-Fi sous un nom. Utilisez-en un par flotte ou configuration radio, et basculez entre eux en un seul clic.

Gérez les profils dans **Paramètres → Profils et réseau** :

- **Ajouter :** appuyez sur **+**, tapez un nom, et appuyez sur **Ajouter**.
- **Changer :** choisissez un profil dans la liste **Profil de flashage**. Il est également disponible sur l'écran de flashage.
- **Modifier :** modifiez n'importe quel champ ; le profil actif est enregistré automatiquement.
- **Supprimer :** sélectionnez le profil et appuyez sur l'icône de suppression. Vous conservez toujours au moins un profil.

Les phrases de liaison et les mots de passe Wi-Fi sont stockés dans le stockage sécurisé et chiffré de votre téléphone.

---

## Configuration de l'appareil

Sur le Dashboard, appuyez sur **Configuration de l'appareil** pour ouvrir la page de paramètres ExpressLRS de l'appareil connecté à l'intérieur de l'application. Utilisez-la pour modifier les paramètres Wi-Fi et de liaison, l'appariement du modèle, le protocole série, le mappage de sortie PWM et d'autres options de l'appareil. L'application maintient la page verrouillée sur votre appareil.

---

## Paramètres

| Section | Ce qu'il y a |
| :--- | :--- |
| Profils et réseau | Profils de flashage, phrase de liaison, réseau Wi-Fi domestique et mot de passe, domaines réglementaires par défaut 2,4 GHz et sub-GHz |
| Application et stockage | Max. de versions en cache, Gestionnaire de firmware, effacer le cache du firmware, langue de l'application, analyses d'utilisation anonymes (activées par défaut ; désactivez avec **Partager les analyses**) |
| Avancé et débogage | Mode Expert et ses outils (ci-dessous) |
| À propos et légal | Version de l'application, mentions légales et licence, soutenir le développement, et **Vérifier les mises à jour** dans l'APK en téléchargement direct |

Modifiez la langue de l'application depuis les Paramètres ou le bouton de langue dans la barre supérieure. ELRS Mobile est disponible en 18 langues.

---

## Mode Expert

Activez **Paramètres → Avancé et débogage → Mode Expert** pour débloquer :

- **Cibles STM32.** Le matériel plus ancien basé sur STM32 ne peut pas être flashé via Wi-Fi, et seule la version ExpressLRS 3.3.x le prend en charge. L'application compile le firmware avec vos paramètres afin que vous puissiez le flasher depuis un PC avec un STLink ou un passthrough Betaflight.
- **Télécharger le binaire.** Enregistrez le fichier firmware compilé au lieu de le flasher, pour un flashage manuel ou une vérification.
- **Exporter le script Lua ELRS.** Enregistrez `elrs.lua` pour les radios EdgeTX et OpenTX.
- **Soumettre un rapport de débogage.** Envoyez les informations de l'appareil et les journaux de l'application pour aider à corriger un bug. Les phrases de liaison et les mots de passe Wi-Fi ne sont jamais inclus.

---

## Dépannage

**Le Dashboard ne trouve pas mon appareil.** Assurez-vous que votre téléphone est toujours connecté au réseau Wi-Fi de l'appareil ; certains téléphones quittent les réseaux qui n'ont pas d'internet. Sur Android, ELRS Mobile maintient son trafic sur ce réseau Wi-Fi même sans internet. Appuyez sur **Réessayer**, ou entrez l'adresse IP depuis l'icône d'engrenage (`10.0.0.1` sur le hotspot propre à l'appareil).

**Je ne peux pas télécharger le firmware.** Déconnectez-vous du hotspot de l'appareil et utilisez un réseau avec internet.

**Mon appareil ne répond plus après un flashage raté.** Maintenez le bouton BOOT enfoncé tout en le branchant via USB pour entrer en mode bootloader, puis flashez à nouveau avec le [ExpressLRS Web Flasher](https://expresslrs.org/flasher). Les appareils compatibles Wi-Fi peuvent également être récupérés en maintenant BOOT pendant 60 secondes pour démarrer le hotspot Wi-Fi. L'écran d'**Aide et support** de l'application contient ces étapes, une FAQ et des liens vers le Discord ExpressLRS.

**Mes profils ont disparu après la mise à jour.** La mise à jour directe de la v1.0.43 ou antérieure vers la v1.0.45 ou ultérieure ne peut pas transférer les profils enregistrés, les phrases de liaison et les paramètres Wi-Fi lors d'une mise à niveau du stockage. L'application vous l'indique une fois ; ressaisissez-les dans les Paramètres.

Les développeurs peuvent vérifier le firmware qu'ELRS Mobile compile avec les [Outils de validation du firmware](/firmware-validation).

<!-- source_hash: 927017dfd36d96b7c787e4972528233d -->