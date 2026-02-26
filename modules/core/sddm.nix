{ pkgs, ... }:

let
  sugar-candy = pkgs.stdenv.mkDerivation {
    pname = "sddm-sugar-candy-theme";
    version = "1.6";
    src = pkgs.fetchFromGitHub {
      owner = "Kangie";
      repo = "sddm-sugar-candy";
      rev = "master";
      sha256 = "0ksslgd75adlky5hvmr77gbim60xdhy19f7ad7izqpkg4i9p7j8w";
    };
    installPhase = ''
      mkdir -p $out/share/sddm/themes/sugar-candy
      cp -a ./* $out/share/sddm/themes/sugar-candy/
      
      # Заменяем фоновое изображение на твое кастомное
      cp -f ${../../home/desktop/pics/HomeIdle.png} $out/share/sddm/themes/sugar-candy/Background.jpg
      
      # Модифицируем theme.conf для корректных настроек
      chmod +w $out/share/sddm/themes/sugar-candy/theme.conf
      sed -i 's/Background="Background.jpg"/Background="Background.jpg"/' $out/share/sddm/themes/sugar-candy/theme.conf
      sed -i 's/ScreenWidth=1920/ScreenWidth=2560/' $out/share/sddm/themes/sugar-candy/theme.conf
      sed -i 's/ScreenHeight=1080/ScreenHeight=1440/' $out/share/sddm/themes/sugar-candy/theme.conf
    '';
  };
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sugar-candy";
    package = pkgs.kdePackages.sddm; # Используем современную версию SDDM
  };

  # Добавляем тему в системные пакеты, чтобы SDDM мог её найти в /run/current-system/sw/share/sddm/themes
  environment.systemPackages = [
    sugar-candy
    pkgs.libsForQt5.qt5.qtgraphicaleffects
    pkgs.libsForQt5.qt5.qtquickcontrols2
    pkgs.libsForQt5.qt5.qtsvg
  ];
}
