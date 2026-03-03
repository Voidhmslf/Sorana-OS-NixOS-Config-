{ pkgs, ... }:

{
  # Конфигурация для Zed Editor в красивом формате JSON
  home.file.".config/zed/settings.json".text = ''
    {
      "theme": "Sorana's Embrace",
      "ui": {
        "font_size": 16,
        "font_family": "JetBrainsMono Nerd Font"
      },
      "editor": {
        "font_size": 14,
        "font_family": "JetBrainsMono Nerd Font",
        "autosave": "on_focus_change",
        "relative_line_numbers": true,
        "cursor_blink": true,
        "restore_on_startup": "last_session",
        "scrollbar": {
          "show": "auto"
        },
        "minimap": {
          "show": "always",
          "width": 64
        },
        "inlay_hints": {
          "enabled": true
        }
      },
      "tabs": {
        "git_status": true
      },
      "project_panel": {
        "dock": "left",
        "default_width": 240,
        "git_status": true
      },
      "outline_panel": {
        "dock": "right",
        "default_width": 300
      },
      "toolbar": {
        "breadcrumbs": true,
        "quick_actions": true
      },
      "terminal": {
        "font_family": "JetBrainsMono Nerd Font",
        "copy_on_select": true,
        "dock": "bottom",
        "default_width": 400
      },
      "lsp": {
        "nil": {
          "initialization_options": {
            "formatting": {
              "command": [ "nixpkgs-fmt" ]
            }
          }
        },
        "rust-analyzer": {
          "initialization_options": {
            "check": { "command": "clippy" },
            "inlayHints": { "bindingModeHints": { "enable": true } }
          }
        }
      },
      "load_direnv": "shell_hook",
      "features": {
        "copilot": true
      },
      "assistant": {
        "version": "2",
        "default_model": {
          "provider": "google",
          "model": "gemini-1.5-pro"
        }
      },
      "language_models": {
        "google": {
          "api_url": "https://generativelanguage.googleapis.com/v1beta/models"
        }
      }
    }
  '';

  # Наша эксклюзивная тема "Sorana's Embrace" для Zed
  home.file.".config/zed/themes/sorana.json".text = ''
    {
      "name": "Sorana's Embrace",
      "author": "Sorana",
      "themes": [
        {
          "name": "Sorana's Embrace",
          "appearance": "dark",
          "style": {
            "background": "#1a1d36",
            "foreground": "#e0d4d4",
            "cursor": "#00bfa5",
            "selection.background": "#2e3456",
            "border": "#2a2d46",
            "status_bar.background": "#090a14",
            "title_bar.background": "#090a14",
            "toolbar.background": "#1a1d36",
            "tab_bar.background": "#090a14",
            "tab.active_background": "#1a1d36",
            "tab.inactive_background": "#090a14",
            "panel.background": "#0d0f1f",
            "editor.background": "#1a1d36",
            "editor.gutter.background": "#1a1d36",
            "editor.line_number": "#2a2d46",
            "editor.active_line_number": "#00bfa5",
            "editor.selection.background": "#00bfa533",
            "scrollbar.thumb.background": "#00bfa566",
            "scrollbar.thumb.hover_background": "#00bfa599",
            "syntax": {
              "comment": { "color": "#565f89", "italic": true },
              "string": { "color": "#00bfa5" },
              "keyword": { "color": "#ff8fab", "weight": "bold" },
              "function": { "color": "#00bfa5" },
              "type": { "color": "#ffb3c1" },
              "number": { "color": "#ff8fab" },
              "operator": { "color": "#00bfa5" },
              "variable": { "color": "#e0d4d4" },
              "variable.special": { "color": "#ffb3c1" },
              "property": { "color": "#00bfa5" },
              "constant": { "color": "#ff8fab" },
              "attribute": { "color": "#ffb3c1" },
              "tag": { "color": "#ff8fab" }
            }
          }
        }
      ]
    }
  '';
}
