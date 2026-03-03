{ pkgs, minesddm, ... }:

{
  services.displayManager.sddm = {
    enable = true;
    theme = "minesddm";
    package = pkgs.kdePackages.sddm;
    wayland.enable = true;
  };

  # Вручную добавляем тему в список доступных для SDDM
  environment.systemPackages = [
    (pkgs.stdenv.mkDerivation {
      name = "sddm-theme-minesddm";
      src = minesddm;
      installPhase = ''
        mkdir -p $out/share/sddm/themes/minesddm
        cp -R minesddm/* $out/share/sddm/themes/minesddm/
      '';
    })
    
    # Современные зависимости для Qt6-версии SDDM
    pkgs.kdePackages.qtconnectivity
    pkgs.kdePackages.qtmultimedia
    pkgs.kdePackages.qtsvg
    pkgs.kdePackages.layer-shell-qt
  ];
}
