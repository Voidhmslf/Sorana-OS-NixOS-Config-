{ pkgs, ... }:

{
  # Включаем Waybar
  programs.waybar = {
    enable = true;
    
    # Мы не можем просто указать source для файлов, так как Nix должен их обработать.
    # Поэтому мы "встраиваем" их содержимое прямо в конфигурацию.
    
    # Читаем JSON конфигурацию. Используем fromJSON, чтобы Nix проверил синтаксис.
    settings.main = builtins.fromJSON (builtins.readFile ./config.jsonc);
    
    # Читаем CSS стили как простой текст.
    style = builtins.readFile ./style.css;
  };

  # Пробрасываем иконки в ~/.config/waybar/icons
  home.file.".config/waybar/icons".source = ./icons;

  # Добавляем скрипт переключения раскладки
  home.file.".config/waybar/scripts/switch_layout.sh" = {
    source = ./switch_layout.sh;
    executable = true;
  };
}
