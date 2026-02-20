{ config, pkgs, ... }:

{
  home.username = "void";
  home.homeDirectory = "/home/void";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  # Пакеты, которые мы устанавливаем для пользователя
  home.packages = with pkgs; [
    pavucontrol # Утилита для управления громкостью (для клика по виджету)
    network-manager-applet # Утилита для управления Wi-Fi (для клика по виджету)
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) # Шрифты с иконками
  ];

  # Импортируем остальные части конфигурации
  imports = [
    ./programs/default.nix
    ./terminal/kitty.nix
    ./desktop/waybar/default.nix # <-- Наш новый Waybar!
  ];

  # --- Конфигурация Rofi (меню приложений) ---
  programs.rofi = {
    enable = true;
    # Тема в моих цветах, чтобы всё было гармонично
    theme = pkgs.lib.mkOptionDefault {
      "*" = {
        background-color: "#090a14";
        text-color: "#e0d4d4";
        accent-color: "#00bfa5";
      };
      "window" = {
        border: 2;
        border-color: "@accent-color";
        width: "50%";
      };
      "listview" = {
        lines: 8;
        columns: 1;
      };
      "element-text" = {
        padding: "8px";
        vertical-align: 0.5;
      };
      "element selected" = {
        background-color: "@accent-color";
        text-color: "@background-color";
      };
    };
  };

  # --- Конфигурация для Zsh и интерактивных утилит ---
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "fzf"
        "zsh-autosuggestions"
        "zsh-syntax-highlighting"
      ];
    };
  };

  # Копируем конфиг hyprland
  xdg.configFile."hypr/hyprland.conf".source = ./desktop/hyprland/hyprland.conf;
}
