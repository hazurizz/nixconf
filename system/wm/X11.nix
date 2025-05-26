{ config, pkgs, userSettings, ... }:

{
  imports = [
    ./fonts.nix
  ];

  services = {
    xserver = {
      # XKB Layout
      xkb = {
        layout = "ph";
        variant = "";
      };

      # X11 Server
      enable = true;
      
      # videoDriver
      videoDrivers = [ "amdgpu" ];
      
      excludePackages = [ pkgs.xterm ];

      displayManager = {
        lightdm.enable = true;
       
        sessionCommands = ''
          ${pkgs.xorg.xset}/bin/xset s off
          ${pkgs.xorg.xset}/bin/xset -dpms
          ${pkgs.xorg.xset}/bin/xset s noblank
        '';
      };

      serverFlagsSection = ''
        Option "BlankTime" "0"
        Option "StandbyTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime" "0"
      '';
    };
  };
  
  services.displayManager.defaultSession = "none+leftwm";
}

