mkdir -p ~/Persistent
cat > ~/Persistent/reparer-wifi.sh <<'SCRIPT'
#!/bin/bash
set -u

echo "=== Réparation Wi-Fi Broadcom BCM4360 ==="

# Désactiver l'anonymisation MAC qui a bloqué le Wi-Fi
sudo mkdir -p /var/lib/live/config
echo 'TAILS_MACSPOOF_ENABLED=false' |
  sudo tee /var/lib/live/config/tails.macspoof >/dev/null

# Retirer les règles qui empêchent le chargement du pilote
for d in /etc/modprobe.d /lib/modprobe.d /usr/lib/modprobe.d; do
  [ -d "$d" ] || continue
  sudo grep -rlE '^[[:space:]]*install[[:space:]]+wl[[:space:]]+/bin/true' "$d" 2>/dev/null |
  while IFS= read -r f; do
    sudo sed -i -E \
      '/^[[:space:]]*install[[:space:]]+wl[[:space:]]+\/bin\/true/s/^/# désactivé pour réparer le Wi-Fi : /' "$f"
  done
done

# Retirer les pilotes concurrents, puis charger wl
sudo modprobe -r b43 bcma ssb wl 2>/dev/null || true
sudo depmod -a
if ! sudo modprobe wl; then
  echo "ÉCHEC : le pilote wl n'a pas pu se charger."
  echo "Vérifie que wl.ko existe pour le noyau actuel."
  read -r -p "Entrée pour fermer..."
  exit 1
fi

# Relancer le gestionnaire réseau
sudo systemctl restart NetworkManager
sleep 3

echo
echo "=== ÉTAT DU WI-FI ==="
ip -br link
nmcli device status
echo
if ip link show wlan0 >/dev/null 2>&1; then
  echo "Interface wlan0 détectée."
else
  echo "Wi-Fi toujours absent : consulter les erreurs avec sudo dmesg | tail -50"
fi
read -r -p "Entrée pour fermer..."
SCRIPT
chmod +x ~/Persistent/reparer-wifi.sh
echo "Script enregistré : ~/Persistent/reparer-wifi.sh"
