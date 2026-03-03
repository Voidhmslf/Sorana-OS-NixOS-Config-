{ ... }:

{
  # Настройка полноценной темы Vesktop (Vencord)
  xdg.configFile."vesktop/themes/SoranaEmbrace.theme.css".text = ''
    /**
     * @name Sorana's Embrace
     * @author Sorana
     * @version 1.0.0
     * @description Элегантная тема в глубоких индиго и изумрудных тонах для SoranaOS.
     * @source https://github.com/Voidhmslf/Sorana-OS-NixOS-Config-
     */

    /* Основные переменные - используем самые базовые селекторы */
    :root {
      --background-primary: #1a1d36 !important;
      --background-secondary: #090a14 !important;
      --background-secondary-alt: #05050a !important;
      --background-tertiary: #05050a !important;
      --background-floating: #090a14 !important;
      --background-accent: #00bfa5 !important;
      
      --text-normal: #e0d4d4 !important;
      --text-muted: #a09494 !important;
      --header-primary: #e0d4d4 !important;
      --header-secondary: #a09494 !important;
      
      --interactive-normal: #e0d4d4 !important;
      --interactive-hover: #00bfa5 !important;
      --interactive-active: #00bfa5 !important;
      
      --brand-experiment: #00bfa5 !important;
      --accent-emerald: #00bfa5 !important;
      --accent-pink: #ff8fab !important;
      
      --channeltextarea-background: #090a14 !important;
      
      /* Исправления для новых слоев Дискорда */
      --bg-overlay-chat: #1a1d36 !important;
      --bg-overlay-app-frame: #05050a !important;
    }

    /* Принудительное окрашивание всех основных контейнеров */
    #app-mount, 
    .app_a01fb1, 
    .bg_d4b370,
    .container_ee69e0,
    .container_e40c16,
    .base_a0339d {
      background-color: #1a1d36 !important;
    }

    /* Сайдбары и списки */
    .sidebar_a4d4d9, 
    .container_adcaac, 
    .members_a31c30, 
    .container_c2739c {
      background-color: #090a14 !important;
    }

    /* Поле ввода */
    .scrollableContainer_d0633d {
      background-color: #05050a !important;
    }

    /* Скругления всего окна */
    .base_a0339d {
      border-radius: 12px !important;
      margin: 8px !important;
      overflow: hidden !important;
    }
  '';

  # Настраиваем основной файл конфигурации, включая нашу новую тему
  xdg.configFile."vesktop/settings/settings.json".text = builtins.toJSON {
    autoUpdate = true;
    autoUpdateNotification = true;
    useQuickCss = false;
    enabledThemes = [ "SoranaEmbrace.theme.css" ];
    enableQuickCss = false;
    discordBranch = "stable";
    minimizeToTray = true;
    arRPC = true;
    splashColor = "rgb(0, 191, 165)";
    splashBackground = "rgb(26, 29, 54)";
    plugins = {
      ChatInputButtonAPI.enabled = false;
      CommandsAPI.enabled = true;
      MessageAccessoriesAPI.enabled = true;
      UserSettingsAPI.enabled = true;
      CrashHandler.enabled = true;
      NoTrack = {
        enabled = true;
        disableAnalytics = true;
      };
      Settings = {
        enabled = true;
        settingsLocation = "aboveNitro";
      };
    };
  };
}
