{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # CLI tools
    vim
    neovim
    lf
    wget
    unzip
    zip
    killall
    gnugrep
    fastfetch
    btop
    cava
    lazygit

    # System info/tools
    inxi
    glxinfo
    pciutils
    usbutils
    hdparm
    hwinfo
    lm_sensors
    libnotify

    # Display/monitor tools
    arandr
  ];
}

