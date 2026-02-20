{ config, pkgs, ... }:

{
  home.username = "void";
  home.homeDirectory = "/home/void";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  # Импортируем остальные части конфигурации
  imports = [
    ./programs/default.nix
    ./terminal/kitty.nix
  ];

  # --- Новая конфигурация для Zsh и интерактивных утилит ---

  # Устанавливаем Zsh как оболочку по умолчанию
  users.defaultUserShell = pkgs.zsh;

  # Включаем fzf (fuzzy finder) и его интеграцию с zsh
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # Настраиваем Zsh
  programs.zsh = {
    enable = true;
    # Включаем Oh My Zsh для плагинов и тем
    oh-my-zsh = {
      enable = true;
      # Устанавливаем тему (robbyrussell - стандартная и чистая, хорошо для начала)
      theme = "robbyrussell";
      # Добавляем плагины для улучшения опыта
      plugins = [
        "git"                     # Полезные сокращения для Git
        "fzf"                     # Интеграция с fzf (Ctrl+R для истории)
        "zsh-autosuggestions"     # Предложения команд на лету
        "zsh-syntax-highlighting" # Подсветка синтаксиса вводимых команд
      ];
    };
  };

  # Копируем конфиг hyprland
  xdg.configFile."hypr/hyprland.conf".source = ./desktop/hyprland/hyprland.conf;
}
