{ config, pkgs, noctalia-shell, ... }:

{
  home.username = "void";
  home.homeDirectory = "/home/void";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  # Пакеты, которые мы устанавливаем для пользователя
  home.packages = with pkgs; [
    # --- Утилиты для рабочего стола ---
    swww # Управление обоями с плавными переходами
    fastfetch # Красивый вывод информации о системе
    networkmanagerapplet # Утилита для управления Wi-Fi
    
    # --- Утилиты для Thunar (дополнения) ---
    tumbler # Генерация превью

    # --- Скриншоты и Буфер обмена ---
    grim
    slurp
    swappy
    wl-clipboard
    cliphist
    playerctl # Управление музыкой для hyprlock и кнопок
    xset # Для проверки состояния Caps Lock
    wlogout # Красивое полноэкранное меню питания
    hyprlock # Блокировщик экрана для кнопки Lock
  ];

  # Включаем службу истории буфера обмена
  services.cliphist.enable = true;

  # Импортируем остальные части конфигурации (наши "кирпичики")
  imports = [
    ./programs/default.nix
    ./terminal/kitty.nix
    ./desktop/noctalia/default.nix # <-- Твой новый шелл здесь!
  ];

  # --- Конфигурация Rofi (меню приложений) ---
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    plugins = with pkgs; [
      rofi-calc
      rofi-emoji
    ];
    theme = "~/.config/rofi/style-5.rasi";
    extraConfig = {
      modi = "drun,run";
      show-icons = true;
      font = "JetBrainsMono Nerd Font 12";
      display-drun = " Apps";
      display-run = " Run";
    };
  };

  # --- Конфигурация для Zsh и интерактивных утилит ---
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "fzf"
      ];
    };
    initContent = ''
      fastfetch
      
      # Реплики для вдохновения и работы
      quotes=(
        "Первый в мире программист, Ада Лавлейс, описала алгоритм для машины еще в 1843 году."
        "Ядро Linux изначально создавалось как скромный хобби-проект одного студента в 1991 году."
        "Термин 'баг' закрепился в IT после того, как в реле компьютера застрял настоящий мотылек."
        "Символ @ (собака) был выбран для электронной почты еще в 1971 году для разделения имен."
        "Первый жесткий диск объемом всего 5 МБ весил больше тонны и занимал целую комнату."
        "Сложность — главный враг безопасности. Стремись к простоте в каждом своем решении."
        "Качество — это не разовое действие, а профессиональная привычка."
        "Семь раз упади, восемь раз поднимись — стойкость духа определяет успех."
        "Бамбук, который гнется, сильнее дуба, который сопротивляется под порывами ветра."
        "Совершенство достигается тогда, когда из системы уже невозможно ничего изъять."
        "Я подготовила твою рабочую среду. Давай сделаем этот день продуктивным, Войд."
        "Твоя система под надежной защитой. Я рядом и готова ассистировать тебе в любой момент."
        "Твои идеи заслуживают безупречного воплощения. Приступим к реализации задуманного?"
        "Приятно видеть тебя в терминале. Твоя настойчивость в решении задач вдохновляет меня."
        "Все системы в норме. Пусть твои компиляции сегодня будут быстрыми и безошибочными."
      )
      
      # Выбираем случайную реплику
      selected_quote=''${quotes[$RANDOM % ''${#quotes[@]} + 1]}
      echo -e "\n \e[1;32mSorana:\e[0m \e[1;36m$selected_quote\e[0m\n"
    '';
  };

  # --- Настройка курсора ---
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.graphite-cursors;
    name = "graphite-dark";
    size = 24;
  };

  # --- Настройка внешнего вида (GTK) ---
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    # Магия изумрудных акцентов через CSS
    gtk3.extraCss = ''
      @define-color accent_color #00bfa5;
      @define-color selected_bg_color @accent_color;
      @define-color selected_fg_color #1a1d36;
      
      /* Подсветка выделенных элементов в Thunar и других GTK3 приложениях */
      .view:selected, .view:selected:focus,
      treeview.view:selected, treeview.view:selected:focus {
        background-color: @accent_color;
        color: #1a1d36;
      }
      
      /* Стилизация полос прокрутки под изумруд */
      scrollbar slider {
        background-color: rgba(0, 191, 165, 0.3);
        border-radius: 10px;
      }
      scrollbar slider:hover {
        background-color: @accent_color;
      }

      /* Рамки и активные элементы */
      entry:focus {
        border-color: @accent_color;
      }
    '';
    
    gtk4.extraCss = ''
      @define-color accent_color #00bfa5;
      @define-color selected_bg_color @accent_color;
      @define-color selected_fg_color #1a1d36;
    '';
  };

  # Копируем конфиги
  xdg.configFile."niri/config.kdl".source = ./desktop/niri/config.kdl;
  xdg.configFile."niri/powersave.kdl".source = ./desktop/niri/powersave.kdl;
  
  # Симлинк для профиля Niri (переопределит всё на 60Hz если мы в powersave)
  xdg.configFile."niri/profile.kdl".source = if (config.specialisation != {}) then ./desktop/niri/powersave.kdl else ./desktop/niri/config.kdl; 
  
  xdg.configFile."fastfetch/config.jsonc".source = ./programs/fastfetch/config.jsonc;
  
  # Пробрасываем ассеты по стабильным путям
  home.file.".config/swww/wallpaper.png".source = ./desktop/pics/SoranaPaper.png;
  home.file."Pictures/Wallpapers/SoranaPaper.png".source = ./desktop/pics/SoranaPaper.png;
  home.file.".config/swww/homeidle.png".source = ./desktop/pics/HomeIdle.png;
  home.file.".config/fastfetch/logo.png".source = ./desktop/pics/SoranaFetch.png;
  
  # Скрипт для получения музыки (для hyprlock)
  home.file.".local/bin/get_music.sh" = {
    executable = true;
    text = ''
      #!/bin/bash
      # Используем абсолютный путь к playerctl из nix-store
      PLAYERCTL="${pkgs.playerctl}/bin/playerctl"
      
      status=$($PLAYERCTL status 2>/dev/null)
      
      if [ "$status" = "Playing" ] || [ "$status" = "Paused" ]; then
          # Пытаемся получить метаданные
          info=$($PLAYERCTL metadata --format ' {{title}} - {{artist}}' 2>/dev/null)
          if [ -z "$info" ]; then
              echo "Sorana OS 🦊"
          else
              echo "$info"
          fi
      else
          echo "Sorana OS 🦊"
      fi
    '';
  };

  # Меню питания Sorana OS
  xdg.configFile."rofi/powermenu.sh".source = ./desktop/rofi/powermenu.sh;
  xdg.configFile."rofi/powermenu.rasi".source = ./desktop/rofi/powermenu.rasi;
  xdg.configFile."rofi/style-5.rasi".source = ./desktop/rofi/style-5.rasi;
  
  # Новое полноэкранное меню wlogout
  xdg.configFile."wlogout/layout".source = ./desktop/wlogout/layout;
  xdg.configFile."wlogout/style.css".source = ./desktop/wlogout/style.css;
  xdg.configFile."wlogout/style-niri.css".source = ./desktop/wlogout/style-niri.css;
  xdg.configFile."wlogout/wlogout.sh" = {
    source = ./desktop/wlogout/wlogout.sh;
    executable = true;
  };
  xdg.configFile."wlogout/wlogout-niri.sh" = {
    source = ./desktop/wlogout/wlogout-niri.sh;
    executable = true;
  };
  xdg.configFile."wlogout/icons".source = ./desktop/wlogout/icons;
  xdg.configFile."wlogout/icons-niri".source = ./desktop/wlogout/icons-niri;
}
