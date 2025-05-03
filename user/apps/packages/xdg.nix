{ config, lib, pkgs, ... }:

{
  xdg = {
    enable = true;

    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";

    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${config.home.homeDirectory}";
      templates = "${config.home.homeDirectory}/media/templates";
      publicShare = "${config.home.homeDirectory}/share";
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/media/music";
      pictures = "${config.home.homeDirectory}/media/pictures";
      videos = "${config.home.homeDirectory}/media/videos";

      extraConfig = {
        XDG_ORG_DIR = "${config.home.homeDirectory}/org";
        XDG_ARCHIVE_DIR = "${config.home.homeDirectory}/archive";
        XDG_NIXCONFS_DIR = "${config.home.homeDirectory}/.nixconfs";
        XDG_GAME_DIR = "${config.home.homeDirectory}/media/games";
        XDG_GAME_SAVE_DIR = "${config.home.homeDirectory}/media/game saves";
      };
    };

    mimeApps = {
      enable = true;

      defaultApplications = {
        # File types
        "application/pdf" = [ "org.pwmt.zathura-pdf-mupdf.desktop" ];
        "image/gif" = [ "feh.desktop" ];
        "image/jpeg" = [ "feh.desktop" ];
        "image/png" = [ "feh.desktop" ];
        "image/webp" = [ "feh.desktop" ];
        "inode/directory" = [ "thunar.desktop" ];
        "text/csv" = [ "nvim.desktop" ];
        "text/plain" = [ "nvim.desktop" ];
        "video/mp4" = [ "mpv.desktop" ];
        "video/webm" = [ "mpv.desktop" ];
        "video/x-matroska" = [ "mpv.desktop" ];
        "audio/mpeg" = [ "mpv.desktop" ];
        "audio/flac" = [ "mpv.desktop" ];
        "audio/ogg" = [ "mpv.desktop" ];
        "audio/wav" = [ "mpv.desktop" ];
        "application/epub+zip" = [ "koreader.desktop" ];
        "application/vnd.oasis.opendocument.text" = [ "libreoffice-writer.desktop" ];
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [ "libreoffice-writer.desktop" ];

        "x-scheme-handler/magnet" = [ "qbittorrent.desktop" ];
      };

      associations.added = config.xdg.mimeApps.defaultApplications;
    };
  };
}

