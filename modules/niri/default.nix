{ config, pkgs, ... }:

{
  programs.niri.enable = true;

  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_DESKTOP = "niri";
    
    # NVIDIA специфичные настройки
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
    MOZ_ENABLE_WAYLAND = "1";
  };

  # Дополнительные пакеты для niri, если нужны специфичные
  environment.systemPackages = with pkgs; [
    xwayland-satellite # Чтобы X11 приложения работали в niri
  ];
}
