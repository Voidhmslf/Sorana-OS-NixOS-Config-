{ config,pkgs, ... }:

{
  home.username = "void";
  home.homeDirectory = "/home/void";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  xdg.configFile."hypr/hyprland.conf".source = ./desktop/hyprland/hyprland.conf;
  
  imports = [
    ./programs/default.nix
    ./terminal/kitty.nix
  ];
}
