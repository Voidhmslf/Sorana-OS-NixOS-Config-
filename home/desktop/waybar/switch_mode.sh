#!/bin/bash

# Sorana OS Power Switcher 🦊✨
# Переключает режимы: Performance (144Hz + Анимации) <-> Powersave (60Hz + Без анимаций)

# Получаем текущий профиль питания
CURRENT_PROFILE=$(powerprofilesctl get)

if [ "$CURRENT_PROFILE" = "performance" ]; then
    # --- ПЕРЕХОДИМ В POWERSAVE ---
    powerprofilesctl set powersave
    
    # Снижаем герцовку на встроенном мониторе (eDP-1)
    niri msg output eDP-1 mode "1920x1080@60.001"
    
    # Замедляем анимации (делаем их практически мгновенными)
    # niri msg action set-animation-slowdown 10.0 # Можно использовать это для "заморозки"
    
    # Отправляем уведомление
    notify-send -i battery-caution "Sorana OS" "Режим энергосбережения включен. Экран: 60Hz. 🔋"
else
    # --- ПЕРЕХОДИМ В PERFORMANCE ---
    powerprofilesctl set performance
    
    # Возвращаем 144Hz на встроенный монитор
    niri msg output eDP-1 mode "1920x1080@144.000"
    
    # Возвращаем плавные анимации
    # niri msg action set-animation-slowdown 1.0
    
    # Отправляем уведомление
    notify-send -i performance "Sorana OS" "Режим максимальной производительности! Экран: 144Hz. ⚡"
fi
