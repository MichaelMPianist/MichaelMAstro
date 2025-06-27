#!/bin/bash
set -e

echo "[*] Updating system..."
sudo apt update && sudo apt upgrade -y

echo "[*] Installing required packages..."
sudo apt install -y indi-full vnc4server autossh avahi-daemon curl git

echo "[*] Setting up udev rules..."
sudo cp payload/udev/99-astro.rules /etc/udev/rules.d/

echo "[*] Installing systemd services..."
sudo cp payload/systemd/*.service /etc/systemd/system/
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable vncserver@pi.service
sudo systemctl enable indiserver.service

echo "[*] Setting up autostart..."
mkdir -p ~/.config/autostart
cp payload/config/autostart_indiserver.desktop ~/.config/autostart/

echo "[✓] Setup complete."
