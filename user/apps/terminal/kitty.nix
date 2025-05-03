{ pkgs, lib, userSettings, ... }:

{

 imports = [
              ./git.nix
              ./cli-collection.nix
            ];

  home.packages = with pkgs; [
    kitty
  ];
  
  programs.kitty.enable = true;
  programs.kitty.settings = {
    background_opacity = lib.mkForce "0.85";
    modify_font = "cell_width 90%";
  };
}
