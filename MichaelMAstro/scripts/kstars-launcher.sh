#!/bin/bash
MODE="$1"

if [ "$MODE" == "remote" ]; then
  echo "[*] Launching KStars in remote INDI mode"
  kstars --indi-host=nebula.local
else
  echo "[*] Launching KStars in local mode"
  kstars
fi
