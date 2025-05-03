{ pkgs, ... }:

{
  imports = [
    ./rofi.nix
    ./xdg.nix
    ./polybar.nix
  ];

  # Collection of useful CLI and GUI apps
  home.packages = with pkgs; [
    # Media & streaming
    mpv
    obs-studio
    flameshot

    # Gaming
    lutris
    heroic
    wineWowPackages.stable

    # System tools
    gedit
    file-roller
    qbittorrent
    polybar-pulseaudio-control

    # Communication & productivity
    discord
    upwork

    # Compositor
    picom
  ];
}

