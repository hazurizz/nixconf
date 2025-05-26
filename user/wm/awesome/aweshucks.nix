{ config, pkgs, lib, ... }:

let
  cfg = config.xsession.windowManager.awesome.aweshucks;
in {
  options.xsession.windowManager.awesome.aweshucks = {
    enable = lib.mkEnableOption "Enable the Aweshucks AwesomeWM config";

    repository = lib.mkOption {
      type = lib.types.str;
      default = "https://github.com/hazurizz/aweshucks";
      description = "Git repository for Aweshucks config.";
    };

    path = lib.mkOption {
      type = lib.types.path;
      default = "${config.home.homeDirectory}/.config/awesome";
      description = "Path to clone Aweshucks into.";
    };
  };

  # Use `pkgs` in the activation step properly
  config = lib.mkIf cfg.enable {
    home.activation.aweshucks = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -d "${cfg.path}" ]; then
        echo "Cloning Aweshucks config to ${cfg.path}"
        ${pkgs.git}/bin/git clone ${cfg.repository} "${cfg.path}"
      else
        echo "Aweshucks config already exists at ${cfg.path}"
      fi
    '';
  };
}

