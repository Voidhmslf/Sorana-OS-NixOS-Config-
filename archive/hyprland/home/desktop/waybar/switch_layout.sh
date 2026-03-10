#!/usr/bin/env bash

# Определяем текущий индекс раскладки для основной клавиатуры
# Ищем активный индекс (0 или 1)
current_index=$(hyprctl devices -j | grep -A 15 "at-translated-set-2-keyboard" | grep "active_layout_index" | awk '{print $2}' | tr -d ',')

# Если вдруг не нашли (например, внешняя клавиатура), по умолчанию 0
if [ -z "$current_index" ]; then
    current_index=0
fi

# Запуск rofi с подсвеченной текущей строкой
layout=$(echo -e "EN\nRU" | rofi -dmenu \
    -p "Layout" \
    -location 1 \
    -yoffset 38 \
    -xoffset 8 \
    -width 60 \
    -hide-scrollbar \
    -line-margin 0 \
    -lines 2 \
    -selected-row "$current_index" \
    -theme-str 'window { width: 80px; } mainbox { children: [ listview ]; } listview { lines: 2; scrollbar: false; } element { padding: 4px; }' \
    -me-select-entry '' \
    -me-accept-entry MousePrimary \
    -i)

case "$layout" in
    "EN")
        hyprctl switchxkblayout all 0
        ;;
    "RU")
        hyprctl switchxkblayout all 1
        ;;
esac
