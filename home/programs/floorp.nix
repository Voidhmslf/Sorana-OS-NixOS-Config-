{ pkgs, config, ... }:

let
  # Твоя прекрасная Сорана на обоях. Берем её прямо из ассетов!
  wallpaper = ../desktop/pics/SoranaPaper.png;
  
  # Наша обновленная палитра для идеального контраста
  emerald-dark = "#06473c";      # Глубокий темно-изумрудный для базы
  lime-accent = "#a3e635";       # Сочный салатовый для активной вкладки
  white-text = "#ffffff";        # Чисто белый текст для темного фона
  black-text = "#000000";        # Черный текст для светлой вкладки
in
{
  # Заставляем Floorp искать конфиги в правильном месте
  home.file.".floorp/void".source = config.lib.file.mkOutOfStoreSymlink "/home/void/.mozilla/firefox/void";
  
  # Обновляем profiles.ini, чтобы Floorp знал о нашем профиле
  home.file.".floorp/profiles.ini".text = ''
    [Profile0]
    Name=void
    IsRelative=1
    Path=void
    Default=1

    [General]
    StartWithLastProfile=1
    Version=2
  '';

  programs.firefox = {
    enable = true;
    package = pkgs.floorp-bin;
    
    profiles.void = {
      id = 0;
      name = "void";
      isDefault = true;

      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "floorp.browser.sidebar.enable" = true;
        "floorp.browser.tabs.vertical" = true;
        "browser.startup.homepage" = "about:newtab";
        "browser.search.defaultenginename" = "DuckDuckGo";
        "browser.compactmode.show" = true;
        "browser.newtabpage.enabled" = true;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "gfx.webrender.all" = true;
        "layers.acceleration.force-enabled" = true;
      };

      # Магия интерфейса (userChrome.css)
      userChrome = ''
        /* Твои обновленные цвета для идеальной читаемости */
        :root {
          --toolbar-bgcolor: ${emerald-dark} !important;
          --toolbar-color: ${white-text} !important;
          --lwt-accent-color: ${emerald-dark} !important;
          --lwt-text-color: ${white-text} !important;
          
          --tab-selected-bgcolor: ${lime-accent} !important;
          --tab-selected-textcolor: ${black-text} !important;
          
          --arrowpanel-background: ${emerald-dark} !important;
          --arrowpanel-color: ${white-text} !important;
          --button-hover-bgcolor: rgba(255, 255, 255, 0.1) !important;
        }

        #nav-bar, #TabsToolbar, #PersonalToolbar, #titlebar {
          background-color: ${emerald-dark} !important;
          color: ${white-text} !important;
        }

        .tabbrowser-tab:not([selected]) .tab-label {
          color: ${white-text} !important;
          opacity: 0.8;
        }

        .tabbrowser-tab[selected] .tab-content {
          background-color: ${lime-accent} !important;
          color: ${black-text} !important;
        }

        .tabbrowser-tab[selected] .tab-label {
          color: ${black-text} !important;
          font-weight: bold !important;
        }

        #main-window, #browser, .browserContainer, #content-deck {
          border-radius: 10px !important;
        }

        .tab-background[selected] {
          background-color: ${lime-accent} !important;
          border-radius: 8px 8px 0 0 !important;
        }

        #nav-bar {
          box-shadow: none !important;
          border-top: none !important;
        }
      '';

      userContent = ''
        /* Усиленная магия для того, чтобы Сорана всегда была на фоне */
        @-moz-document url-prefix("about:newtab"), url-prefix("about:home"), url("about:floorp-home") {
          html, body, #root, .activity-stream {
            background-image: url("file://${wallpaper}") !important;
            background-size: cover !important;
            background-position: center !important;
            background-attachment: fixed !important;
            background-color: transparent !important;
          }
          
          /* Убираем стандартные фоны Activity Stream, которые могут перекрывать нас */
          .outer-wrapper, .inner-wrapper {
            background-color: transparent !important;
          }

          .main {
            background-color: rgba(6, 71, 60, 0.4) !important;
            backdrop-filter: blur(8px) !important;
            border-radius: 15px !important;
            padding: 20px !important;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.5) !important;
          }
          
          /* Настройка текста и ссылок для лучшей видимости */
          .search-wrapper .search-label, .search-wrapper .search-info {
            color: ${white-text} !important;
          }
        }
      '';
    };
  };
}
