#!/bin/bash
autossh -f -M 0 -N -L 7624:localhost:7624 pi@nebula.local
