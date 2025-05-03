{ config, pkgs, lib, userSettings, unstable, ... }:

{
  imports = [ 
    ./aweshucks.nix 
  ];

  xsession.enable = true;

  xsession.windowManager.awesome = {
    enable = true;

    aweshucks.enable = true;

    luaModules = with pkgs.luaPackages; [
      luafilesystem
      luarocks
      luaposix
      vicious
      dkjson
      ldbus
      http
      lgi
    ];
  };
}

