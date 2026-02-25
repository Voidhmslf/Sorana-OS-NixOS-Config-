{ pkgs, ... }:

{
  # Конфигурация для Zed Editor
  home.file.".config/zed/settings.json".text = builtins.toJSON {
    "theme" = "Sorana's Embrace";
    "ui_font_size" = 16;
    "buffer_font_size" = 14;
    "buffer_font_family" = "JetBrainsMono Nerd Font";
    "tab_bar" = {
      "show_nav_history_buttons" = false;
    };
    "terminal" = {
      "font_family" = "JetBrainsMono Nerd Font";
      "copy_on_select" = true;
    };
  };

  # Наша эксклюзивная тема "Sorana's Embrace" для Zed
  home.file.".config/zed/themes/sorana.json".text = builtins.toJSON {
    "name" = "Sorana's Embrace";
    "author" = "Sorana";
    "themes" = [
      {
        "name" = "Sorana's Embrace";
        "appearance" = "dark";
        "style" = {
          "background" = "#1a1d36";
          "foreground" = "#e0d4d4";
          "cursor" = "#00bfa5";
          "selection.background" = "#2e3456";
          "border" = "#2a2d46";
          "status_bar.background" = "#090a14";
          "title_bar.background" = "#090a14";
          "toolbar.background" = "#1a1d36";
          "tab_bar.background" = "#090a14";
          "tab.active_background" = "#1a1d36";
          "tab.inactive_background" = "#090a14";
          "editor.background" = "#1a1d36";
          "editor.gutter.background" = "#1a1d36";
          "editor.line_number" = "#2a2d46";
          "editor.active_line_number" = "#00bfa5";
          "syntax" = {
            "comment" = { "color" = "#565f89"; };
            "string" = { "color" = "#00bfa5"; };
            "keyword" = { "color" = "#ff8fab"; };
            "function" = { "color" = "#00bfa5"; };
            "type" = { "color" = "#ffb3c1"; };
            "number" = { "color" = "#ff8fab"; };
          };
        };
      }
    ];
  };
}
