{
  description = "nixsaiga's flakes";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix/release-24.11";
    
    nixpkgs-f2k.url = "github:moni-dz/nixpkgs-f2k";
  };

  outputs = inputs@{ self, nixpkgs-f2k, ... }:
    let
       # ---------- SYSTEM LIBS ---------- #
      lib = inputs.nixpkgs.lib;
      home-manager = inputs.home-manager;
      
      # ---------- SYSTEM SETTINGS ---------- #
      systemSettings = {
        system = "x86_64-linux"; # nix system
        host = "nixsaiga"; # hostname
        profile = "desktop"; # select a profile
        timezone = "Asia/Manila"; # timezone
        locale = "en_PH.UTF-8"; # locale
        localeSettings = "fil_PH"; # extra locale

      };

      # --------------- USER SETTINGS --------------- #
      userSettings = rec {
        username = "hazaki"; # username
        name = "hazaki"; # name/identifier
        email = "lsrhazaki@gmail.com"; # email (used for certain configurations)
        term = "kitty"; # selected terminal
        editor = "vim"; # selected editor
        wm = "left"; # selected window manager
        theme = "tomorrow-night"; # selected theme
        font = "Intel One Mono"; # selected font
        fontPkg = pkgs.intel-one-mono; # font pkg
        defaultBrowser = "floorp"; # default browser
        leftwmTheme = "hazaki"; # leftwm theme
        nixconfsDir = "/home/${username}/.nixconfs"; # dotfiles directory
      };

      # --------------- PKGS CONFIGURATION ----------------- #
      pkgs = import inputs.nixpkgs {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
        overlays = [

          inputs.nixpkgs-f2k.overlays.stdenvs # f2k overlays
          inputs.nixpkgs-f2k.overlays.compositors # f2k overlays
             
          (final: prev: {
           awesome = inputs.nixpkgs-f2k.packages.${systemSettings.system}.awesome-git; # override awesome to use awesome-git from f2k
          })          
          
          (import ./user/apps/packages/upwork/overlay.nix)  # Custom overlay for Upwork-related packages
        ];
      };

      # --------- UNSTABLE PACKAGE CONFIGURATION --------- #
      unstable = import inputs.unstable {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
        # No overlays here
      };

    in {

      # -------------- HOME CONFIGURATIONS --------------- #
      homeConfigurations = {
        hazaki = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./profile/desktop/home.nix ]; # load home.nix from selected PROFILE
          extraSpecialArgs = {
            inherit inputs;
            inherit unstable;
            inherit userSettings;
          };
        };
      };
            
      # -------------- NIXOS CONFIGURATIONS --------------- #
      nixosConfigurations = {
        nixsaiga = lib.nixosSystem {
          system = systemSettings.system;
          modules = [ ./profile/desktop/configuration.nix ]; # load configuration.nix from selected PROFILE
          specialArgs = {
            inherit inputs;
            inherit unstable;
            inherit userSettings;
            inherit systemSettings;
          };
        };
      };
    };
}

