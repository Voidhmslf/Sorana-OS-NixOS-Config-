{ config, pkgs, noctalia-shell, ... }:

{
  imports = [
    noctalia-shell.homeModules.default
  ];

  # Пакеты, необходимые для работы шелла и его виджетов
  home.packages = with pkgs; [
    brightnessctl # Управление яркостью
    playerctl     # Музыкальные виджеты
    pavucontrol   # Звук
  ];

  # --- Noctalia Shell Configuration 🦊✨ ---
  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
    package = noctalia-shell.packages.${pkgs.system}.default;
    
    # Наши фирменные цвета Sorana-Embrace
    colors = {
      mPrimary = "#00bfa5";
      mOnPrimary = "#1a1d36";
      mSecondary = "#ff8fab";
      mOnSecondary = "#1a1d36";
      mTertiary = "#8abeb7";
      mOnTertiary = "#1a1d36";
      mError = "#ff8fab";
      mOnError = "#1a1d36";
      mSurface = "#1a1d36";
      mOnSurface = "#e0d4d4";
      mSurfaceVariant = "#090a14";
      mOnSurfaceVariant = "#8abeb7";
      mOutline = "#2a2d46";
      mShadow = "#090a14";
      mHover = "#00bfa5";
      mOnHover = "#1a1d36";
    };

    settings = {
      bar = {
        position = "top";
        floating = true;
        margin = 10;
        backgroundOpacity = 0.9;
        blur = true;
        widgets = {
          left = [
            { id = "Launcher"; }
            { id = "Clock"; }
            { id = "ActiveWindow"; }
          ];
          center = [
            { id = "Workspace"; }
          ];
          right = [
            { id = "Tray"; }
            { 
              id = "KeyboardLayout";
              displayMode = "forceOpen";
            }
            { id = "Network"; }
            { id = "Battery"; }
            { id = "Volume"; }
            { id = "Brightness"; }
            { id = "ControlCenter"; }
          ];
        };
      };
      general = {
        animationSpeed = 1.0;
        radiusRatio = 1.2;
      };
      location = {
        name = "Almaty";
      };
      colorSchemes = {
        useWallpaperColors = false;
        darkMode = true;
      };
      wallpaper = {
        enabled = false; # Отключаем, чтобы не конфликтовало с swww
      };
    };
  };

  # Обманываем Noctalia, подсовывая наши обои вместо стандартных
  xdg.configFile."noctalia/Assets/Wallpaper/noctalia.png".source = ../pics/SoranaPaper.png;
}
