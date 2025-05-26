{ pkgs, userSettings, ... }:

let
  defaultBrowser = userSettings.defaultBrowser;

  allModules = {
    firefox = import ./firefox.nix;
    floorp = import ./floorp.nix;
    librewolf = import ./librewolf.nix;
  };

  browserNames = builtins.attrNames allModules;
in {
  imports = builtins.map (name: allModules.${name}) browserNames;
}

