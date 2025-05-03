{ pkgs, ... }:

{
 programs.rofi = {
   enable = true;
   font = "Iosevka Nerd Font 18";
   plugins = [ pkgs.rofi-calc ]; 
   extraConfig = {}; 
}; 


}
