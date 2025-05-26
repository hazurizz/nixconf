{ config, lib, pkgs, userSettings, ... }:

let
  currentTheme = userSettings.leftwmTheme;
in {

  home.file.".config/leftwm/themes/current" = {
    recursive = true;
    source = builtins.path {
      path = ../../wm/left/themes/${currentTheme};
      name = "${currentTheme}-theme";
      filter = path: type: type == "regular" || type == "directory";
    };
  };

  # Symlink the LeftWM configuration file

  home.file.".config/leftwm/config.ron".source =
    config.lib.file.mkOutOfStoreSymlink ./config.ron;
}

