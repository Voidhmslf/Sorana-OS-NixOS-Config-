{ pkgs, ... }:

{
  # Используем GRUB 2 в качестве загрузчика
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
    useOSProber = true;
    
    # Темы Minegrub
    theme = let
      # Тема "Выбор миров" (второе меню)
      world-sel-src = pkgs.fetchFromGitHub {
        owner = "Lxtharia";
        repo = "minegrub-world-sel-theme";
        rev = "main";
        sha256 = "1vicgjv05wk6m9yc51kr9akngybdknw5jq1dx75zvl8hlkhly6c0";
      };
    in pkgs.stdenv.mkDerivation {
      name = "minegrub-world-selection";
      src = world-sel-src;
      installPhase = ''
        mkdir -p $out
        cp -r minegrub-world-selection/* $out/
      '';
    };

    # Логика двойного меню
    extraConfig = ''
      set config_file=mainmenu.cfg
      if [ -z "$chosen" ] ; then
        if [ -n "$config_file" ] ; then
          configfile $prefix/$config_file
        fi
      fi
    '';

    # Дополнительные файлы для главного меню
    extraFiles = let
      # Тема "Главное меню" (первое меню)
      main-menu-src = pkgs.fetchFromGitHub {
        owner = "Lxtharia";
        repo = "minegrub-theme";
        rev = "main";
        sha256 = "1lv9wsam2lccidyyr4alm7d10jycsgi26bgijxnjdzjci8041y8s";
      };
      
      minegrub-main-theme = pkgs.stdenv.mkDerivation {
        name = "minegrub-main-theme";
        src = main-menu-src;
        installPhase = ''
          mkdir -p $out
          cp -r minegrub/* $out/
        '';
      };

      mainmenu-cfg = pkgs.writeText "mainmenu.cfg" ''
        # Loading the theme and fonts 
        loadfont $prefix/themes/minegrub/Minecraft30.pf2
        loadfont $prefix/themes/minegrub/Monocraft22.pf2
        insmod png
        set theme=$prefix/themes/minegrub/theme.txt
        export theme

        set timeout_style=menu
        set timeout=15

        menuentry "              Singleplayer (NixOS)" {
            configfile $prefix/grub.cfg 
        }

        menuentry "              Multiplayer (Network)" {
            echo "I don't know how network boot works, but Sorana loves you! 🦊"
            sleep 3
        } 

        menuentry "           Uefi Setting Realm" $menuentry_id_option 'uefi-firmware' {
            fwsetup
        }
      '';
    in {
      "mainmenu.cfg" = mainmenu-cfg;
      "themes/minegrub" = minegrub-main-theme;
    };
  };

  boot.loader.timeout = 15;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  # Используем последнее ядро
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Параметры ядра для тихой загрузки
  boot.kernelParams = [
    "quiet"
    "loglevel=2"
    "systemd.show_status=false"
    "rd.udev.log_level=2"
    "rd.driver.pre-udev-show-status=false"
    "vt.global_cursor_default=0"
    "pci=noaer"
  ];
}
