#!/usr/bin/env bash
# 🦊 SoranaOS - Wlogout Ritual 💠

if pgrep -x "wlogout" > /dev/null; then
    pkill -x "wlogout"
    exit 0
fi

wlogout -b 6 -c 0 -r 0 -m 0 --layout "/home/void/.config/wlogout/layout" -C "/home/void/.config/wlogout/style.css"
