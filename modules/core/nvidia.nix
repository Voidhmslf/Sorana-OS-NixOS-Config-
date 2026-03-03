{ config, pkgs, lib, ... }:

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
    powerManagement.finegrained = lib.mkDefault true; # По умолчанию вкл для экономии батареи
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

  # Специализации для разных режимов работы
  specialisation = {
    # Режим энергосбережения (NVIDIA Offload)
    powersave.configuration = {
      system.nixos.label = "Power-Save-Hybrid";
      hardware.nvidia.prime.offload.enable = lib.mkForce true;
      hardware.nvidia.prime.offload.enableOffloadCmd = lib.mkForce true;
      hardware.nvidia.prime.sync.enable = lib.mkForce false;
      hardware.nvidia.powerManagement.finegrained = lib.mkForce true;
    };

    # Режим максимальной производительности (NVIDIA Sync)
    performance.configuration = {
      system.nixos.label = "Performance-Nvidia-Sync";
      hardware.nvidia.prime.offload.enable = lib.mkForce false;
      hardware.nvidia.prime.offload.enableOffloadCmd = lib.mkForce false;
      hardware.nvidia.prime.sync.enable = lib.mkForce true;
      hardware.nvidia.powerManagement.finegrained = lib.mkForce false;
    };
  };

  # Дополнительные параметры ядра для стабильности Wayland на NVIDIA
  boot.kernelParams = [ 
    "nvidia_drm.modeset=1" 
    "nvidia_drm.fbdev=1" 
    "amdgpu.sg_display=0"
  ];
}
