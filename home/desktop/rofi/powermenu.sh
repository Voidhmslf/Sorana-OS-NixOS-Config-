#!/usr/bin/env bash

# Опции
shutdown="󰐥 Выключить"
reboot="󰜉 Перезагрузить"
sleep="󰒲 Сон"
hibernate="󰏦 Гибернация"
logout="󰍃 Выйти"

# Запуск rofi
selected_option=$(echo -e "$shutdown
$reboot
$sleep
$hibernate
$logout" | rofi -dmenu -i -p "Sorana OS" -config ~/sorana-os/home/desktop/rofi/powermenu.rasi)

# Выполнение действия
case $selected_option in
    "$shutdown")
        systemctl poweroff
        ;;
    "$reboot")
        systemctl reboot
        ;;
    "$sleep")
        systemctl suspend
        ;;
    "$hibernate")
        systemctl hibernate
        ;;
    "$logout")
        hyprctl dispatch exit
        ;;
esac
