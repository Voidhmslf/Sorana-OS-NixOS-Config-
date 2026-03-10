{ pkgs, lib, config, ... }:

let
  # Путь к папке с EasyEDA
  easyeda-src = ./easyeda-linux-x64;
  
  # Проверяем, существует ли папка (Nix увидит её только если она есть)
  hasEasyEDA = builtins.pathExists easyeda-src;

  # Создаем "пакет" только если папка на месте
  easyeda-pkg = if hasEasyEDA then pkgs.stdenv.mkDerivation {
    pname = "easyeda";
    version = "6.5.51";
    src = easyeda-src;
    
    installPhase = ''
      mkdir -p $out/opt/easyeda
      cp -r . $out/opt/easyeda
    '';
  } else null;

  # Твоя магия со steam-run и зависимостями
  mySteamRun = (pkgs.steam.override {
    extraPkgs = pkgs: with pkgs; [
      nss
      nspr
      gtk3
      pango
      cairo
      atk
      gdk-pixbuf
      glib
      dbus
      xorg.libX11
      xorg.libxcb
      xorg.libXcomposite
      xorg.libXcursor
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXi
      xorg.libXrandr
      xorg.libXrender
      xorg.libXScrnSaver
      xorg.libXtst
      alsa-lib
      cups
      expat
      libdrm
      mesa
    ];
  }).run;

  # Скрипт для запуска
  easyeda-launcher = if hasEasyEDA then pkgs.writeShellScriptBin "easyeda" ''
    ${mySteamRun}/bin/steam-run ${easyeda-pkg}/opt/easyeda/easyeda "$@"
  '' else null;

in
{
  # Добавляем наш лаунчер только если он создан
  home.packages = lib.optional hasEasyEDA easyeda-launcher;

  # Создаем ярлык только если есть пакет
  xdg.desktopEntries.easyeda = lib.mkIf hasEasyEDA {
    name = "EasyEDA";
    genericName = "PCB Design Tool";
    exec = "easyeda";
    icon = "${easyeda-pkg}/opt/easyeda/icon/256x256/easyeda.png";
    terminal = false;
    categories = [ "Development" "Electronics" ];
  };
}
