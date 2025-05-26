{ pkgs, lib, userSettings, ... }:

let
  isDefault = userSettings.defaultBrowser == "firefox";
in {
  home.packages = [ pkgs.firefox ];

  xdg.mimeApps.defaultApplications = lib.mkIf isDefault {
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
  };

  home.sessionVariables = lib.mkIf isDefault {
    BROWSER = "firefox";
  };
}

