{ config, pkgs, userSettings, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;
  home.stateVersion = "24.11";  # Please read the comment before changing.

  # Import other user-specific configurations
  imports = [
    ../../user/stylix
    ../../user/apps/browsers
    ../../user/apps/packages
    (./. + "../../../user/apps/terminal"+("/"+userSettings.term)+".nix")
    (./. + "../../../user/wm"+("/"+userSettings.wm+"/"+userSettings.wm)+".nix")
  ];

  # Define session variables
  home.sessionVariables = {
    EDITOR = userSettings.editor;
    TERM = userSettings.term;
    LEFTWM_THEME = userSettings.leftwmTheme; # check which theme is enabled type in command echo $LEFTWM_THEME

    # Additional environment variables
    FDOTDIR = "$HOME/.config/fish";
    CARGO_HOME = "$HOME/.cargo";
  };

  # User-specific settings for GTK icon theme based on polarity
  gtk.iconTheme = {
    package = pkgs.papirus-icon-theme;
    name = if (config.stylix.polarity == "dark") then "Papirus-Dark" else "Papirus-Light";
  };

  # Systemd user service configuration for reloading units
  systemd.user.startServices = "sd-switch";

  # Enable Home Manager to manage itself
  programs.home-manager.enable = true;

  # Optional: You can add any further customizations as required
}

