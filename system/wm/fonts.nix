{ pkgs, ... }:{

  # Fonts are nice to have
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "Monaspace"
          "Noto"
          "Iosevka"
        ];
      })
      noto-fonts-color-emoji
    ];   
 }; 
     
   fonts.fontDir.enable = true;
   
} 
