{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    wget
    yt-dlp # Для тестов и спасения видео
    ntfs3g
    exfatprogs
    acl # Утилиты для управления Access Control Lists (getfacl, setfacl)
    libimobiledevice # на случай, если ты когда-нибудь подключишь iPhone
    ifuse # для работы с файлами через libimobiledevice
    polkit_gnome # Агент аутентификации для GUI
    blueman # Менеджер Bluetooth
    gamescope # Микро-композитор для игр
    ciscoPacketTracer9 # Симулятор сетей от Cisco
  ];

  # Включаем Steam и сопутствующие игровые сервисы
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Открываем порты для Remote Play
    dedicatedServer.openFirewall = true; # Открываем порты для локальных серверов
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  # Включаем Thunar на системном уровне для лучшей интеграции
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
}
