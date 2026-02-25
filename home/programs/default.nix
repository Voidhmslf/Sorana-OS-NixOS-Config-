{ pkgs, ... }:

{
  imports = [
    ./easyeda
    ./firefox.nix
    ./vscode.nix
    ./zed.nix
  ];

  home.packages = with pkgs; [
    # Твои браузеры
    
    # Твои рабочие инструменты
    neovim
    gemini-cli
    material-design-icons
    
    # Сетевые инструменты
    networkmanager         # Вернет nmtui
    networkmanagerapplet   # Графический апплет для трея (nm-applet)
    brightnessctl          # Утилита для управления яркостью
    
    # И любые другие программы, которые ты захочешь добавить в будущем
    telegram-desktop
    spotify
  ];
  home.file.".gemini/prompt.md".source = ./gemini/GEMINI.md;
}