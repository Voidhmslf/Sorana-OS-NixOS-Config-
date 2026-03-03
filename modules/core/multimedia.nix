{ pkgs, ... }:

{
  # Включаем rtkit
  security.rtkit.enable = true;

  # Включаем звуковой сервер Pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;

    # Исправление для USB-аудио и фризов
    extraConfig.pipewire."99-usb-audio-fix" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 1024;
        "default.clock.min-quantum" = 512;
        "default.clock.max-quantum" = 2048;
      };
    };
    
    # Тонкая настройка ALSA для USB устройств
    extraConfig.pipewire."99-alsa-config" = {
      "monitor.alsa.rules" = [
        {
          matches = [ { "device.name" = "~alsa_card.usb-*" ; } ];
          actions = {
            update-props = {
              "api.alsa.period-size" = 1024;
              "api.alsa.headroom" = 512;
              "session.suspend-on-idle" = false; # Не даем засыпать USB аудио
            };
          };
        }
      ];
    };
  };

  # Переменные окружения для стабильности мультимедиа
  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    # Мы НЕ устанавливаем LIBVA_DRIVER_NAME здесь, чтобы система сама выбрала AMD
  };

  # Включаем Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  # Поддержка аппаратного ускорения видео
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva
      libva-utils
      vdpauinfo
      mesa
      # Драйверы для AMD/Intel
      libva-vdpau-driver
      libvdpau-va-gl
      # Драйверы для NVIDIA
      nvidia-vaapi-driver
    ];
  };

  environment.systemPackages = with pkgs; [
    ffmpeg-full
    libva-utils
    vdpauinfo
    blueman
    overskride
    pavucontrol
    qpwgraph
    easyeffects
    rnnoise-plugin
  ];

  # Настройка фильтра шумоподавления для PipeWire
  services.pipewire.extraConfig.pipewire."99-input-denoising" = {
    "context.modules" = [
      {
        name = "libpipewire-module-filter-chain";
        args = {
          "node.description" = "Noise Suppression Source";
          "media.name" = "Noise Suppression Source";
          "filter.graph" = {
            nodes = [
              {
                type = "ladspa";
                name = "rnnoise";
                plugin = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
                label = "noise_suppressor_mono";
                control = {
                  "VAD Threshold (%)" = 50.0;
                  "VAD Grace Period (ms)" = 200;
                  "Retroactive VAD Grace (ms)" = 0;
                };
              }
            ];
          };
          "capture.props" = {
            "node.name" = "capture.rnnoise_source";
            "node.passive" = true;
            "audio.rate" = 48000;
          };
          "playback.props" = {
            "node.name" = "rnnoise_source";
            "media.class" = "Audio/Source";
            "audio.rate" = 48000;
          };
        };
      }
    ];
  };
}
