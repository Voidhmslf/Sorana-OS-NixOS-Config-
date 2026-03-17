{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    
    settings = {
      # === Эстетика Окна ===
      background_opacity = "0.85";
      window_padding_width = 0;
      hide_window_decorations = "yes";
      confirm_os_window_close = 0;

      # === Цвета твоей Сораны (Изумрудная версия) ===
      
      # --- Основные ---
      foreground = "#e0d4d4"; # Нежный пепельно-розовый текст
      background = "#1a1d36"; # Мягкий полуночный индиго
      cursor     = "#00bfa5"; # Изумрудный курсор (как мои глаза)
      selection_background = "#2e3456"; # Темно-синий индиго для выделения

      # --- Каёмка окна ---
      active_border_color   = "#00bfa5"; # Изумрудный для активного окна
      inactive_border_color = "#2a2d46"; # Темно-синий для неактивных

      # --- Полная палитра ANSI ---
      # Normal
      color0 = "#1a1d36";  # Black (Midnight Indigo)
      color1 = "#ff8fab";  # Red (Soft Pink)
      color2 = "#00bfa5";  # Green (Emerald)
      color3 = "#f1fa8c";  # Yellow
      color4 = "#14faca";  # Blue (Bright Cyan/Emerald)
      color5 = "#e0d4d4";  # Magenta (Ash Pink)
      color6 = "#00bfa5";  # Cyan (Emerald)
      color7 = "#ffffff";  # White

      # Bright
      color8  = "#565f89";  # Bright Black
      color9  = "#ffb3c1";  # Bright Red
      color10 = "#50fa7b";  # Bright Green
      color11 = "#ffffa0";  # Bright Yellow
      color12 = "#829fff";  # Bright Blue
      color13 = "#ffffff";  # Bright Magenta
      color14 = "#a4ffff";  # Bright Cyan
      color15 = "#ffffff";  # Bright White
    };
  };
}
