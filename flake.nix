{
  description = "nixsaiga's flakes";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix/release-24.11";
  };

  outputs = inputs@{ self, ... }:
    let
      lib = inputs.nixpkgs.lib;
      homeManager = inputs.home-manager;

      systemSettings = {
        system = "x86_64-linux";
        hostname = "nixsaiga";
        profile = "desktop";
        timezone = "Asia/Manila";
        locale = "en_PH.UTF-8";
        localeSettings = "fil_PH";
      };

      # Stable pkgs with overlay (main system base)
      pkgs = import inputs.nixpkgs {
        inherit (systemSettings) system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
        overlays = [
          (import ./user/apps/packages/upwork/overlay.nix)  # Custom overlay for Upwork-related packages
        ];
      };

      # Unstable pkgs (if you need to use them)
      unstable = import inputs.nixpkgs-unstable {
        inherit (systemSettings) system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
        # No overlays here
      };

      # User configuration
      userSettings = rec {
        username = "hazaki";
        name = "hazaki";
        email = "lsrhazurizz@gmail.com";
        nixconfsDir = "/home/${username}/.nixconfs";

        theme = "tomorrow-night";
        font = "Intel One Mono";
        fontPkg = pkgs.intel-one-mono;
        term = "alacritty";
        editor = "vim";
        wm = "left";
        defaultBrowser = "floorp";
        leftwmTheme = "hazaki";
      };

    in {
      nixosConfigurations = {
        nixsaiga = lib.nixosSystem {
          inherit (systemSettings) system;
          modules = [ ./profiles/desktop/configuration.nix ];
          specialArgs = {
            inherit
              inputs
              unstable
              userSettings
              systemSettings;
          };
        };
      };

      homeConfigurations = {
        hazaki = homeManager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./profiles/desktop/home.nix ];
          extraSpecialArgs = {
            inherit
              inputs
              unstable
              userSettings;
          };
        };
      };
    };
}

