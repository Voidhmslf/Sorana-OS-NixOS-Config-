#!/usr/bin/env bash

# Твой идеальный буфер обмена Sorana's Embrace
cliphist list | rofi -dmenu 
    -p "Clipboard" 
    -theme-str 'window { width: 500px; border-radius: 15px; border: 2px; border-color: #00bfa5; background-color: #1a1d36; } mainbox { children: [ listview ]; } listview { lines: 8; scrollbar: false; } element { padding: 8px; border-radius: 10px; } element selected { background-color: rgba(0, 191, 165, 0.2); text-color: #00bfa5; }' 
    | cliphist decode | wl-copy
