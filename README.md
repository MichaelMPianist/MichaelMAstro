# Nebula Astrophotography Pi Setup

This repo automates your Raspberry Pi (Nebula) setup for remote astrophotography.

## 🚀 Features

- INDI server autostart with saved config
- TigerVNC server auto-start
- USB and power management for stability
- mDNS for easy SSH/VNC (`nebula.local`)
- KStars support for local and remote profiles
- SSH tunneling wrapper for secure remote access
- USB SSD auto-mounting to `/mnt/astrodrive`

## 🛠️ Setup

```bash
bash <(curl -s https://raw.githubusercontent.com/YOURNAME/astro-nebula-setup/main/install.sh)
```

## 🔌 Remote Access

- **VNC Viewer** to `nebula.local:1`
- **SSH**: `ssh pi@nebula.local`
- **Secure VNC Tunnel**: run `~/scripts/vnc-over-ssh.sh` on your PC

## 🔭 KStars Setup

Create 2 profiles in KStars:
- **Local Nebula**: connects directly to INDI running on Pi
- **Remote Nebula**: set KStars on PC to connect to `nebula.local`

## 🔐 Notes

- Replace `YOUR-SSD-UUID-HERE` in `setup.sh` with your actual SSD UUID
- Run `lsblk -f` to find it
