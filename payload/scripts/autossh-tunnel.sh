#!/bin/bash
# Set this up only if your remote PC is publicly accessible or via VPN
AUTOSSH_POLL=60
autossh -M 0 -f -N -R 5901:localhost:5901 yourpcuser@yourpcaddress
