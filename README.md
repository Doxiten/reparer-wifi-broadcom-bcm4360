Réparation Wi-Fi Broadcom BCM4360 — Linux Tails

Script Bash destiné à diagnostiquer et tenter de rétablir le Wi-Fi sur certains systèmes Linux Tails équipés d'une carte Broadcom BCM4360.
Fonctionnalités

    Désactive la configuration d'anonymisation MAC de Tails via le fichier tails.macspoof.
    Recherche et commente certaines règles modprobe empêchant le chargement du module wl.
    Retire les modules Wi-Fi concurrents b43, bcma et ssb.
    Tente de charger le pilote Broadcom wl.
    Redémarre NetworkManager et affiche l'état des interfaces réseau.

Prérequis

    Un système Linux Tails compatible avec cette configuration.
    Une carte Wi-Fi Broadcom BCM4360.
    Les privilèges administrateur (sudo).
    Le module noyau wl installé et compatible avec le noyau en cours d'utilisation.

Installation

Télécharge le fichier reparer-wifi.sh depuis ce dépôt, puis ouvre un terminal dans le dossier où il est enregistré.

Rends le script exécutable :

chmod +x reparer-wifi.sh

Lance-le :

./reparer-wifi.sh

Le script demande les privilèges administrateur lorsque nécessaire.
Vérification

Le script affiche les interfaces réseau et l'état des périphériques détectés. Si le Wi-Fi reste indisponible, examine les messages du noyau :

sudo dmesg | tail -50

Avertissements

    Ce script modifie des fichiers de configuration système et décharge des modules noyau. Examine son contenu avant de l'exécuter.
    La désactivation de l'anonymisation MAC peut réduire la protection de la vie privée fournie par Tails.
    Le module propriétaire wl doit être disponible et compatible avec le noyau utilisé.
    Le nom de l'interface Wi-Fi n'est pas nécessairement wlan0.
    Ce script ne garantit pas que le problème sera résolu sur toutes les configurations.
