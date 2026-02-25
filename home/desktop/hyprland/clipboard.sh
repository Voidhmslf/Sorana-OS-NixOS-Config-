#!/usr/bin/env bash

# Скрипт для красивого вызова буфера обмена через Rofi
# Использует нашу фирменную палитру Sorana's Embrace

cliphist list | rofi -dmenu 
    -p "Clipboard" 
    -theme-str 'window { width: 500px; border-radius: 15px; border: 2px; border-color: @accent; background-color: @bg; } mainbox { children: [ listview ]; } listview { lines: 8; scrollbar: false; } element { padding: 8px; border-radius: 10px; } element selected { background-color: rgba(0, 191, 165, 0.2); text-color: @accent; }' 
    | cliphist decode | wl-copy
