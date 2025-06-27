#!/bin/bash
PROFILE=${1:-remote}
echo "🪐 Launching KStars with profile: $PROFILE"
kstars --indi-profile "$PROFILE"
