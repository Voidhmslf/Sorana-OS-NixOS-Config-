# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/hyprland/default.nix
    ];

  # Включаем Zsh на уровне системы, чтобы оболочка работала корректно
  programs.zsh.enable = true;

  # Use the rEFInd EFI boot loader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = false;
  boot.loader.refind = {
    enable = true;
    maxGenerations = 5;
    extraConfig = ''
      include themes/catppuccin/mocha.conf
      dont_scan_dirs EFI/nixos, EFI/systemd, EFI/BOOT, EFI/Linux
      showtools reboot, shutdown, firmware
    '';
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  # Скрипт для автоматической установки темы Catppuccin для rEFInd
  system.activationScripts.refind-theme = {
    text = let
      catppuccin-refind = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "refind";
        rev = "e92ad6f4673e30fbc79e69c9cbe3780fb9a3f05f";
        sha256 = "1z252rfzsx8k8pkygbknicdrl9z2j5ibkd9qx1m7r9w4yn98r3yz";
      };
    in ''
      mkdir -p /boot/EFI/refind/themes/catppuccin
      cp -rf ${catppuccin-refind}/mocha.conf /boot/EFI/refind/themes/catppuccin/mocha.conf
      cp -rf ${catppuccin-refind}/assets /boot/EFI/refind/themes/catppuccin/
    '';
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.kernelModules = [ "amdgpu" ];
  
  # Настройка видеодрайверов
  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];

  # Включаем базовую поддержку графики
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    # Режимы работы и настройки для Wayland
    modesetting.enable = true;
    powerManagement.enable = true; # Важно для ноутбуков и выхода из сна
    powerManagement.finegrained = true; # Экономия энергии для Offload
    open = false; # Используем проприетарный драйвер (стабильнее для RTX 3060)
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Настройка PRIME для гибридной графики
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      # Адреса шин (Bus ID) теперь находятся в hardware-configuration.nix
    };
  };

  # Дополнительные параметры ядра для стабильности Wayland на NVIDIA
  boot.kernelParams = [ 
    "nvidia_drm.modeset=1" 
    "nvidia_drm.fbdev=1" 
    "amdgpu.sg_display=0"
  ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      
      # Оптимизация загрузки для Казахстана и СНГ
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://mirror.yandex.ru/nixos/" # Зеркало Yandex (РФ)
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      # Ускоряем параллельную загрузку
      max-substitution-jobs = 20;
      connect-timeout = 5;
      min-free = 128 * 1024 * 1024; # 128MB
      max-free = 1024 * 1024 * 1024; # 1GB
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d"; # Чистим мусор старше 7 дней
    };
  };

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "sorana";
  
  # Возвращаемся к стандартному NetworkManager
  networking.networkmanager.enable = true;
  
  users.users.void = {
    isNormalUser = true;
    description = "Void";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    shell = pkgs.zsh;
  };

  # Set your time zone.
  time.timeZone = "Asia/Almaty";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     tree
  #   ];
  # };

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    git
    wget
  ];

  # Включаем шрифты, необходимые для красивого отображения иконок
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    font-awesome
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}
