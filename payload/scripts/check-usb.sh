#!/bin/bash
if lsusb | grep -qi 'Sony'; then
    echo "✅ Sony Alpha detected."
else
    echo "⚠️ Sony Alpha not detected!"
    notify-send "Sony Alpha not detected!"
fi
