{ pkgs, lib, userSettings, ... }:

let
  isDefault = userSettings.defaultBrowser == "floorp";
in {
  home.packages = [ pkgs.floorp ];

  xdg.mimeApps.defaultApplications = lib.mkIf isDefault {
    "text/html" = "floorp.desktop";
    "x-scheme-handler/http" = "floorp.desktop";
    "x-scheme-handler/https" = "floorp.desktop";
    "x-scheme-handler/about" = "floorp.desktop";
    "x-scheme-handler/unknown" = "floorp.desktop";
  };

  home.sessionVariables = lib.mkIf isDefault {
    BROWSER = "floorp";
  };
}

