{ config, pkgs, ... }:

{
  boot.initrd.kernelModules = [ "amdgpu" ];
  
  # Настройка видеодрайверов
  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];

  # Включаем базовую поддержку графики
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    # Режимы работы и настройки для Wayland
    modesetting.enable = true;
    powerManagement.enable = true; # Важно для ноутбуков и выхода из сна
    powerManagement.finegrained = false; # Отключаем для стабильности HDMI
    open = false; # Используем проприетарный драйвер (стабильнее для RTX 3060)
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Настройка PRIME для гибридной графики
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      # Адреса шин (Bus ID) теперь находятся в hardware-configuration.nix
    };
  };

  # Дополнительные параметры ядра для стабильности Wayland на NVIDIA
  boot.kernelParams = [ 
    "nvidia_drm.modeset=1" 
    "nvidia_drm.fbdev=1" 
    "amdgpu.sg_display=0"
  ];
}
