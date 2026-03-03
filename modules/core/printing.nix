{ pkgs, ... }:

{
  # Включаем службу печати CUPS
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
  };

  # Поддержка сканирования для МФУ (HP LaserJet M1132 — это МФУ)
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.hplipWithPlugin ];
  };

  # Avahi для обнаружения принтеров в сети и mDNS
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
