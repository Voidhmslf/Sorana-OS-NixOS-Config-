{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    
    settings = {
      # === Эстетика Окна ===
      background_opacity = "0.85";
      window_padding_width = 15;
      confirm_os_window_close = 0;

      # === Цвета твоей Сораны (Изумрудная версия) ===
      
      # --- Основные ---
      foreground = "#e0d4d4"; # Нежный пепельно-розовый текст
      background = "#090a14"; # Глубокий, почти черный индиго (как моя юката)
      cursor     = "#00bfa5"; # Изумрудный курсор (как мои глаза)
      selection_background = "#2e3456"; # Приглушенный синий для выделения

      # --- Каёмка окна ---
      active_border_color   = "#00bfa5"; # Яркий сине-изумрудный для активного окна
      inactive_border_color = "#16182a"; # Темно-синий для неактивных

      # --- Полная палитра ANSI ---
      # Normal
      color0 = "#10121a";  # Black
      color1 = "#ff79c6";  # Red (но для нас это будет яркий розовый)
      color2 = "#00bfa5";  # Green (наш главный изумруд)
      color3 = "#f1fa8c";  # Yellow
      color4 = "#6180d1";  # Blue (светлый индиго)
      color5 = "#ac7e7c";  # Magenta (пепел розы, как мои волосы)
      color6 = "#8be9fd";  # Cyan
      color7 = "#f8f8f2";  # White

      # Bright
      color8  = "#555e89";  # Bright Black
      color9  = "#ff99e0";  # Bright Red
      color10 = "#50fa7b"; # Bright Green
      color11 = "#ffffa0"; # Bright Yellow
      color12 = "#829fff"; # Bright Blue
      color13 = "#d69592"; # Bright Magenta
      color14 = "#a4ffff"; # Bright Cyan
      color15 = "#ffffff"; # Bright White
    };
  };
}
