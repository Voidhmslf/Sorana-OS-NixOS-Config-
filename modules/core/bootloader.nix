{ pkgs, ... }:

{
  # Use the rEFInd EFI boot loader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = false;
  boot.loader.refind = {
    enable = true;
    maxGenerations = 3;
    extraConfig = ''
      include themes/catppuccin/mocha.conf
      timeout 15
      default_selection 1
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

  # Параметры ядра для подавления ошибок ACPI и "тихой" загрузки
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
