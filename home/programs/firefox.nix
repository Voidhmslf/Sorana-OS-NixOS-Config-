{ pkgs, config, ... }:

let
  # Твоя прекрасная Сорана на обоях. Берем её прямо из ассетов!
  wallpaper = ../desktop/pics/SoranaPaper.png;
  
  # Наша обновленная палитра для идеального контраста
  emerald-dark = "#1a1d36";      # Мягкий полуночный индиго для базы
  lime-accent = "#00bfa5";       # Изумрудный акцент для активной вкладки
  white-text = "#e0d4d4";        # Пепельно-розовый текст для темного фона
  black-text = "#1a1d36";        # Темный индиго текст для светлой вкладки
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox; # Используем стандартный Firefox
    
    profiles.void = {
      id = 0;
      name = "void";
      isDefault = true;

      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.startup.homepage" = "about:newtab";
        "browser.search.defaultenginename" = "DuckDuckGo";
        "browser.compactmode.show" = true;
        "browser.newtabpage.enabled" = true;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        
        # Оптимизация для скорости и плавности (как мы делали во Floorp)
        "gfx.webrender.all" = true;
        "layers.acceleration.force-enabled" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.rdd-ffmpeg.enabled" = true;
        "media.av1.enabled" = true;
        "media.hardware-video-decoding.enabled" = true;
        "media.navigator.mediadatadecoder_vpx_enabled" = true;
        "media.ffvpx.enabled" = true;
        "media.cache_size" = 524288;
        "dom.ipc.processCount.webContent" = 8;
        "network.http.http3.enable" = true;
        "privacy.resistFingerprinting" = true; 
        "privacy.trackingprotection.enabled" = true; 
        "media.videocontrols.picture-in-picture.enabled" = true;
      };

      # Магия интерфейса (userChrome.css) - адаптировано под Firefox
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
        /* Усиленная магия для того, чтобы Сорана всегда была на фоне новой вкладки */
        @-moz-document url-prefix("about:newtab"), url-prefix("about:home") {
          html, body, #root, .activity-stream {
            background-image: url("file://${wallpaper}") !important;
            background-size: cover !important;
            background-position: center !important;
            background-attachment: fixed !important;
            background-color: transparent !important;
          }
          
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
          
          .search-wrapper .search-label, .search-wrapper .search-info {
            color: ${white-text} !important;
          }
        }
      '';
    };
  };
}
