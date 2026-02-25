{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default.userSettings = {
      # --- Визуальная Магия Сораны ---
      "workbench.colorTheme" = "Default Dark Modern"; # Базовая тема, которую мы перекрасим
      "workbench.colorCustomizations" = {
        # Основные цвета окна
        "editor.background" = "#1a1d36";
        "editor.foreground" = "#e0d4d4";
        "sideBar.background" = "#16182a";
        "sideBar.foreground" = "#e0d4d4";
        "activityBar.background" = "#090a14";
        "activityBar.foreground" = "#00bfa5";
        "editorGroupHeader.tabsBackground" = "#16182a";
        "tab.activeBackground" = "#1a1d36";
        "tab.activeForeground" = "#00bfa5";
        "tab.inactiveBackground" = "#16182a";
        "tab.inactiveForeground" = "#ac7e7c";
        
        # Статусбар (наш изумрудный акцент)
        "statusBar.background" = "#00bfa5";
        "statusBar.foreground" = "#1a1d36";
        "statusBarItem.hoverBackground" = "#14faca";
        
        # Выделение и курсор
        "editor.selectionBackground" = "#2e3456";
        "editorCursor.foreground" = "#00bfa5";
        
        # Терминал внутри VSCode
        "terminal.background" = "#1a1d36";
        "terminal.foreground" = "#e0d4d4";
      };

      # Общие настройки комфорта
      "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace'";
      "editor.fontSize" = 14;
      "editor.minimap.enabled" = false;
      "workbench.startupEditor" = "none";
      "window.menuBarVisibility" = "toggle";
    };
  };
}
