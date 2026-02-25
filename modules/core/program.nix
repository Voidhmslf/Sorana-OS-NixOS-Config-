{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    wget
    yt-dlp # Для тестов и спасения видео
    ntfs3g
    exfatprogs
    libimobiledevice # на случай, если ты когда-нибудь подключишь iPhone
    ifuse # для работы с файлами через libimobiledevice
    polkit_gnome # Агент аутентификации для GUI
    blueman # Менеджер Bluetooth
  ];

  # Включаем Thunar на системном уровне для лучшей интеграции
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
}
