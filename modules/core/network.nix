{ ... }:

{
  networking.hostName = "sorana";
  networking.networkmanager.enable = true;

  # Включаем IPv6 обратно, раз дело было в провайдере
  networking.enableIPv6 = true;
}
