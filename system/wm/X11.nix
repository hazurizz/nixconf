{ config, pkgs, lib, ... }:

{
  imports = [
    ./fonts.nix
  ];

  services.xserver = {
    enable = true;

    # ✅ Display Manager (LightDM)
    displayManager = {
      lightdm.enable = true;

      sessionCommands = ''
        ${pkgs.xorg.xset}/bin/xset s off
        ${pkgs.xorg.xset}/bin/xset -dpms
        ${pkgs.xorg.xset}/bin/xset s noblank
      '';
    };

    # ✅ Window Manager (LeftWM)
    windowManager.leftwm.enable = true;
     
    # ✅ Don't include xterm
    excludePackages = [ pkgs.xterm ];

    # ✅ X server power-saving options
    serverFlagsSection = ''
      Option "BlankTime" "0"
      Option "StandbyTime" "0"
      Option "SuspendTime" "0"
      Option "OffTime" "0"
    '';
  };

  # ✅ Set LeftWM as the default session
  services.displayManager.defaultSession = "none+leftwm";
}

