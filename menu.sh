#!/bin/bash

# Afficher le menu
echo "Bienvenue dans l'antre !"
echo " ================================= "
echo " =============================== "
echo " ========================== "
echo " ===================== "
echo " =============== "
echo "▄████▄  ▓█████ ▓█████▄  ██▀███   ██▓ ▄████▄    ██████  ▄████▄   ▄▄▄▄   ▄▄▄██▀▀▀▄▄▄██▀▀▀"
echo "▒██▀ ▀█  ▓█   ▀ ▒██▀ ██▌▓██ ▒ ██▒▓██▒▒██▀ ▀█  ▒██    ▒ ▒██▀ ▀█  ▓█████▄   ▒██     ▒██   "
echo "▒▓█    ▄ ▒███   ░██   █▌▓██ ░▄█ ▒▒██▒▒▓█    ▄ ░ ▓██▄   ▒▓█    ▄ ▒██▒ ▄██  ░██     ░██   "
echo "▒▓▓▄ ▄██▒▒▓█  ▄ ░▓█▄   ▌▒██▀▀█▄  ░██░▒▓▓▄ ▄██▒  ▒   ██▒▒▓▓▄ ▄██▒▒██░█▀ ▓██▄██▓ ▓██▄██▓  "
echo "▒ ▓███▀ ░░▒████▒░▒████▓ ░██▓ ▒██▒░██░▒ ▓███▀ ░▒██████▒▒▒ ▓███▀ ░░▓█  ▀█▓▓███▒   ▓███▒   "
echo "░ ░▒ ▒  ░░░ ▒░ ░ ▒▒▓  ▒ ░ ▒▓ ░▒▓░░▓  ░ ░▒ ▒  ░▒ ▒▓▒ ▒ ░░ ░▒ ▒  ░░▒▓███▀▒▒▓▒▒░   ▒▓▒▒░   "
echo "  ░  ▒    ░ ░  ░ ░ ▒  ▒   ░▒ ░ ▒░ ▒ ░  ░  ▒   ░ ░▒  ░ ░  ░  ▒   ▒░▒   ░ ▒ ░▒░   ▒ ░▒░   "
echo "░           ░    ░ ░  ░   ░░   ░  ▒ ░░        ░  ░  ░  ░         ░    ░ ░ ░ ░   ░ ░ ░   "
echo "░ ░         ░  ░   ░       ░      ░  ░ ░            ░  ░ ░       ░      ░   ░   ░   ░   "
echo "░                ░                   ░                 ░              ░                 "
echo " ================================= "
echo " =============================== "
echo " ========================== "
echo " ===================== "
echo " =============== "
echo " =============== "





options=("localnetwork arp scan" "scan de ports" "network check" "wifi scan"   "Capture de Paquets"
         "Recherche Whois" "Scan de Vulnérabilités" "Traceroute" "Test de Ping" "quitter" )

scan_network() {
    echo "Scanning du réseau local..."
    
    # Utiliser arp-scan pour scanner les appareils connectés
    if command -v arp-scan &> /dev/null
    then
        sudo arp-scan --localnet
    else
        echo "arp-scan n'est pas installé. Utilisez 'sudo apt install arp-scan' pour l'installer."
    fi
    

}

port_scan() { read -p "Adresse IP : " ip; sudo nmap -p- "$ip"; }
network_monitor() { sudo tcpdump -i any; }
network_monitor() { sudo tcpdump -i any; }
wifi_scan() { nmcli dev wifi list; }
packet_capture() { read -p "Interface (ex: eth0) : " interface; sudo tcpdump -i "$interface" -w capture.pcap; }
whois_lookup() { read -p "Domaine ou IP : " query; whois "$query"; }
vuln_scan() { read -p "Adresse IP : " ip; sudo nmap --script vuln "$ip"; }
trace_route() { read -p "Domaine ou IP : " destination; traceroute "$destination"; }
ping_test() { read -p "Domaine ou IP : " host; ping -c 4 "$host"; }

# Boucle pour afficher le menu et lire l'entrée de l'utilisateur
select option in "${options[@]}"
do
    case $REPLY in
        1) echo "scan reseau en cours...." 
        scan_network ;; #  Permet de détecter les appareils connectés au réseau.

        2) echo "Vous avez sélectionné l'option 2" 
        port_scan;; # Scanner les ports d'une adresse IP spécifique pour voir quels services sont ouverts.

       3) echo "Surveillance réseau"; network_monitor ;; #  Surveiller le trafic réseau pour détecter toute activité suspecte.

        4) echo "Scan Wi-Fi"; wifi_scan ;; # Lister les réseaux Wi-Fi disponibles et afficher des détails comme le canal et la force du signal.

        5) echo "Capture de paquets"; packet_capture ;; # Capturer des paquets sur une interface réseau spécifique pour les analyser plus tard.

        6) echo "Recherche Whois"; whois_lookup ;; # Utilisé pour rechercher des informations sur un nom de domaine ou une adresse IP.

        7) echo "Scan de vulnérabilités"; vuln_scan ;; # Effectuer des scans pour détecter des vulnérabilités connues sur une cible.

        8) echo "Traceroute"; trace_route ;; # Affiche le chemin emprunté par les paquets pour atteindre une adresse IP.

        9) echo "Test de Ping"; ping_test ;; # Vérifie si un hôte est joignable et mesure la latence

        10) echo "Au revoir !"; break ;;
        *) echo "Option invalide";;
    esac
done



 