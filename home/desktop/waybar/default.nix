{ pkgs, ... }:

{
  # Включаем Waybar
  programs.waybar = {
    enable = true;
  };

  # Пробрасываем конфигурацию и стили через xdg.configFile для корректной работы путей
  # Мы используем прямые ссылки на файлы, чтобы Waybar точно их видел
  xdg.configFile."waybar/config".source = ./config.jsonc;
  xdg.configFile."waybar/style.css".source = ./style.css;
  
  # Пробрасываем иконки в ~/.config/waybar/icons
  xdg.configFile."waybar/icons".source = ./icons;

  # Добавляем скрипт переключения раскладки
  xdg.configFile."waybar/scripts/switch_layout.sh" = {
    source = ./switch_layout.sh;
    executable = true;
  };

  # Добавляем скрипт переключения режимов питания
  xdg.configFile."waybar/scripts/switch_mode.sh" = {
    source = ./switch_mode.sh;
    executable = true;
  };
}
