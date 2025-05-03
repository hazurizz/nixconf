{ pkgs, userSettings, ... }:{

  imports = [
              ./gc.nix
              ./zram.nix
              ./programs.nix
            ];
            
  # Services.
  services = {
     flatpak.enable = false;
     getty.autologinUser = userSettings.username;
     gnome.gnome-keyring.enable = true;
     gvfs.enable = true;
     tumbler.enable = true;
     dbus = {
       enable = true;
       packages = [ pkgs.dconf ];
    };
  };
}

