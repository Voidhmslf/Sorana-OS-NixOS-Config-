#!/usr/bin/env bash

# Sorana OS Layout Switcher for Niri 🦊✨

# Запуск rofi для выбора раскладки
layout=$(echo -e "EN\nRU" | rofi -dmenu \
    -p "Layout" \
    -location 1 \
    -yoffset 38 \
    -xoffset 8 \
    -width 60 \
    -hide-scrollbar \
    -line-margin 0 \
    -lines 2 \
    -theme-str 'window { width: 80px; } mainbox { children: [ listview ]; } listview { lines: 2; scrollbar: false; } element { padding: 4px; }' \
    -me-select-entry '' \
    -me-accept-entry MousePrimary \
    -i)

case "$layout" in
    "EN")
        niri msg action switch-layout 0
        ;;
    "RU")
        niri msg action switch-layout 1
        ;;
esac
