{ config, lib, pkgs, userSettings, ... }:

let
  currentTheme = userSettings.leftwmTheme;
in {
  # Install LeftWM
  home.packages = [ pkgs.leftwm ];

  # Set up .xsession to launch LeftWM (for display managers like LightDM or startx)
home.file.".xsession".text = lib.mkIf (userSettings.wm == "left") ''
  exec leftwm
'';

  home.file.".config/leftwm/themes/current" = {
    recursive = true;
    source = builtins.path {
      path = ../../wm/left/themes/${currentTheme};
      name = "${currentTheme}-theme";
      filter = path: type: type == "regular" || type == "directory";
    };
  };

  home.file.".config/leftwm/config.ron".source =
    config.lib.file.mkOutOfStoreSymlink ./config.ron;
}

