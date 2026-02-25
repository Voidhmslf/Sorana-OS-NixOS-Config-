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

  # Включаем сервисы для работы с внешними дисками и флешками
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.tumbler.enable = true; # Превью для файлов
  security.polkit.enable = true;
  programs.gpaste.enable = true;

  # Поддержка различных файловых систем
  boot.supportedFilesystems = [ "ntfs" "exfat" ];

  # Set your time zone.
  time.timeZone = "Asia/Almaty";

  # Включаем шрифты, необходимые для красивого отображения иконок
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    font-awesome
  ];
}
