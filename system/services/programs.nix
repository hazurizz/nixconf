{ pkgs, ... }:{

  # Enable Programs.
  programs = {
     fish.enable = true;
     xfconf.enable= true;
     dconf.enable = true;
     thunar = {
        enable = true;
         plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
      };
    };
 }
