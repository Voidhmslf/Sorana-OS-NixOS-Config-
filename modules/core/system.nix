{ pkgs, ... }:

{
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

  # Управление питанием для ноутбуков
  services.power-profiles-daemon.enable = true;

  # Включаем сервисы для работы с внешними дисками и флешками
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.tumbler.enable = true; # Превью для файлов
  security.polkit.enable = true;
  security.pam.services.hyprlock = {}; # Чтобы hyprlock мог принимать пароль
  
  # Поддержка различных файловых систем
  boot.supportedFilesystems = [ "ntfs" "exfat" ];

  # Подавление спама ядра в TTY (оставляем только критические ошибки)
  boot.kernel.sysctl = {
    "kernel.printk" = "2 2 2 2";
  };

  # Настройка цветов консоли (TTY) для Ly и общего вида
  console = {
    colors = [
      "1a1d36" # 0: background (глубокий индиго)
      "ff8fab" # 1: red (розовый)
      "00bfa5" # 2: green (изумруд)
      "f0c674" # 3: yellow
      "81a2be" # 4: blue
      "b294bb" # 5: magenta
      "8abeb7" # 6: cyan
      "e0d4d4" # 7: white (пепельно-розовый текст)
      "969896" # 8: bright black
      "ff8fab" # 9: bright red
      "00bfa5" # 10: bright green
      "f0c674" # 11: bright yellow
      "81a2be" # 12: bright blue
      "b294bb" # 13: bright magenta
      "8abeb7" # 14: bright cyan
      "ffffff" # 15: bright white
    ];
  };

  # Set your time zone.
  time.timeZone = "Asia/Almaty";

  # Включаем шрифты, необходимые для красивого отображения иконок
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    font-awesome
  ];
}
