{ config, pkgs, systemSettings, userSettings, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../../system/hardware-configuration.nix
      ../../system/hardware/graphics.nix
      ../../system/services/services.nix
      ../../system/security/security.nix
      ../../system/wm/X11.nix
      ../../system/stylix
    ];

  # Bootloader configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = systemSettings.hostname; # Define your hostname.
  networking.networkmanager.enable = true;

  # Timezone and Locale
  time.timeZone = systemSettings.timezone;
  i18n = {
    defaultLocale = systemSettings.locale;
    extraLocaleSettings = builtins.listToAttrs (map (name: {
      inherit name;
      value = systemSettings.localeSettings;
    }) [
      "LC_ADDRESS" "LC_IDENTIFICATION" "LC_MEASUREMENT" "LC_MONETARY"
      "LC_NAME" "LC_NUMERIC" "LC_PAPER" "LC_TELEPHONE" "LC_TIME"
    ]);
  };

  # User account
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Pulse Audio
  hardware.pulseaudio.enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Installed packages
  environment.systemPackages = with pkgs; [
    # Desktop Apps
    git
    firefox
    galculator
    pavucontrol
    lxqt.lxqt-policykit
    networkmanagerapplet

    # Screenshotting
    flameshot
  ];

  # Shell
  environment.shells = with pkgs; [ fish ];
  users.defaultUserShell = pkgs.fish;

  # Portals
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "gtk";
  };

  # System state version
  system.stateVersion = "24.11"; # Did you read the comment?

  # Enable experimental features for nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

