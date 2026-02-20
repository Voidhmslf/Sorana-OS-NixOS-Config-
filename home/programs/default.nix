{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Твои браузеры
    floorp-bin
    
    # Твои рабочие инструменты
    vscode
    neovim
    gemini-cli
    # И любые другие программы, которые ты захочешь добавить в будущем
    telegram-desktop
    spotify
  ];
  home.file.".gemini/prompt.md".source = ./gemini/GEMINI.md;
}