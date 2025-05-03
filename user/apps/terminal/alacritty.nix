{ pkgs, lib, userSettings, ... }:

{

 imports = [
              ./git.nix
              ./cli-collection.nix
            ];

  home.packages = with pkgs; [
    alacritty
  ];
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    window.opacity = lib.mkForce 0.85;
  };
}
