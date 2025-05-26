{ pkgs, lib, userSettings, ... }:

let
  isDefault = userSettings.defaultBrowser == "librewolf";
in {
  home.packages = [ pkgs.librewolf ];

  xdg.mimeApps.defaultApplications = lib.mkIf isDefault {
    "text/html" = "librewolf.desktop";
    "x-scheme-handler/http" = "librewolf.desktop";
    "x-scheme-handler/https" = "librewolf.desktop";
    "x-scheme-handler/about" = "librewolf.desktop";
    "x-scheme-handler/unknown" = "librewolf.desktop";
  };

  home.sessionVariables = lib.mkIf isDefault {
    BROWSER = "librewolf";
  };
}

