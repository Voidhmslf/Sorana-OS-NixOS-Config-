#!/usr/bin/env bash
# 🦊 SoranaOS - Wlogout HYPR Ritual 💠

if pgrep -x "wlogout" > /dev/null; then
    pkill -x "wlogout"
    exit 0
fi

# Экспортируем только самое необходимое для GTK
export GDK_BACKEND="wayland"
export XDG_CONFIG_HOME="$HOME/.config"

wlogout -b 6 -c 0 -r 0 -m 0 --layout "/home/void/.config/wlogout/layout" -C "/home/void/.config/wlogout/style-hypr.css"
