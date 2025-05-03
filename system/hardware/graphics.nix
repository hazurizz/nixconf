{ pkgs, ... }:{

  imports = [
              ./pipewire.nix
            ];

hardware.graphics = {
     enable = true;
     enable32Bit = true;
     extraPackages = with pkgs; [
          mesa
          amdvlk 
          rocmPackages.clr.icd 
       ];
    };
  }
