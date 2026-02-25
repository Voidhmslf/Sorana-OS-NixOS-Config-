{ pkgs, ... }:

{
  # Включаем Zsh на уровне системы
  programs.zsh.enable = true;

  users.users.void = {
    isNormalUser = true;
    description = "Void";
    extraGroups = [ "networkmanager" "wheel" "video" "storage" "audio" "bluetooth" ];
    shell = pkgs.zsh;
  };
}
