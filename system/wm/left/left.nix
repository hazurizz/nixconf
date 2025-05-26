{ config, pkgs, userSettings, ... }:

{
  services.xserver = {
    windowManager.leftwm.enable = true;

  };
}
