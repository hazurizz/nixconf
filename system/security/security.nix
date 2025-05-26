{ pkgs, ... }:{

  imports = [ 
              ./firewall.nix
            ];

   # Security
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services.login.enableGnomeKeyring = true;
  };
 }
