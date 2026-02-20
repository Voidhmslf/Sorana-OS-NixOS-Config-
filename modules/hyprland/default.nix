{ config, pkgs, ... }:

{
  programs.hyprland.enable = true;

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
    floorp-bin
    vscode
    neovim
    spotify
    gemini-cli
  ];
}
