{ config, pkgs, ... }:

{
  programs.hyprland.enable = true;

  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
    
    # Исправление для Firefox/Floorp на Wayland
    MOZ_ENABLE_WAYLAND = "1";
    EGL_PLATFORM = "wayland";
  };

  environment.systemPackages = with pkgs; [
    kitty
    vscode
    zed-editor
    neovim
    spotify
    gemini-cli
  ];
}
