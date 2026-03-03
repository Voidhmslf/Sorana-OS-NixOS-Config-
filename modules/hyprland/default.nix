{ config, pkgs, ... }:

{
  programs.hyprland.enable = true;

  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    WLR_NO_HARDWARE_CURSORS = "1";
    
    # Магия для стабильности NVIDIA на Wayland
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct"; # Ускоряет и стабилизирует Electron/Chromium (VSCode, Discord)
    
    # Исправление для Firefox/Floorp на Wayland
    MOZ_ENABLE_WAYLAND = "1";
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
