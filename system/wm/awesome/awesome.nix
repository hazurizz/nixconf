# In your NixOS configuration, to use awesome-git

{ config, pkgs, userSettings, ... }:

{
   services.xserver = {
    windowManager.awesome = {
      enable = true;  # Enable AwesomeWM
      package = awesome-git;  # Use awesome-git from f2k
    };
  };
}
