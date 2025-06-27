#!/bin/bash
set -e

echo "🔭 Setting up Nebula Pi for remote astrophotography..."

# 1. Install required packages
sudo apt update
sudo apt install -y tigervnc-standalone-server avahi-daemon net-tools git indi-full kstars-bleeding

# 2. Set up mDNS
sudo systemctl enable avahi-daemon
sudo systemctl start avahi-daemon

# 3. Copy INDI autostart config
mkdir -p ~/.config/autostart
cp "$(dirname "$0")/config/autostart_indiserver.desktop" ~/.config/autostart/

# 4. Create autostart INDI server script
mkdir -p ~/scripts
cat << 'EOF' > ~/scripts/start-indi.sh
#!/bin/bash
indiserver -v -m 100 -f ~/scripts/profile.indi &
EOF
chmod +x ~/scripts/start-indi.sh

# 5. Copy systemd VNC server config
sudo cp "$(dirname "$0")/systemd/vncserver@pi.service" /etc/systemd/system/vncserver@pi.service
sudo systemctl enable vncserver@pi

# 6. USB & Power management tweaks
sudo sed -i '/GRUB_CMDLINE_LINUX=/ s/"$/ usbcore.autosuspend=-1"/' /etc/default/grub
sudo update-grub

# 7. Optional: Setup USB SSD mount point
UUID=$(lsblk -o UUID,MOUNTPOINT,LABEL | grep -i -v boot | grep -i -v '/$' | grep -i -v '/mnt' | awk '{print $1}' | head -n 1)
if [ -n "$UUID" ]; then
  echo "UUID=$UUID /mnt/astrodrive ext4 defaults,nofail 0 2" | sudo tee -a /etc/fstab
  echo "✅ Auto-mounted SSD with UUID $UUID"
else
  echo "⚠️ No suitable external SSD found. Please edit /etc/fstab manually."
fi
sudo mkdir -p /mnt/astrodrive

# 8. Optional: Create SSH tunnel wrapper script
mkdir -p ~/scripts
cat << 'EOF' > ~/scripts/vnc-over-ssh.sh
#!/bin/bash
ssh -L 5901:localhost:5901 pi@nebula.local
EOF
chmod +x ~/scripts/vnc-over-ssh.sh

echo "✅ Setup complete. Please reboot your Pi!"

# 9. Udev rules for cameras and devices
sudo cp "$(dirname "$0")/udev/99-astro.rules" /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger
