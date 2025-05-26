{ config, pkgs, ... }:{

  programs.yazi = {
    enable = true;
    settings = {
      manager = {
        ratio = [
          1
          2
          2
        ];
        sort_by = "natural";
        sort_sensitive = true;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "none";
        show_hidden = true;
        show_symlink = true;
      };

      keymap = {
        normal = {
          "Enter"     = "open";       # Open with Enter key
          "Backspace" = "back";       # Go back with Backspace
          "q"         = "quit";       # Quit Yazi
          "gg"        = "goto_top";   # Go to top of the list
          "G"         = "goto_bottom";# Go to bottom
          "j"         = "down";       # Move down
          "k"         = "up";         # Move up
          "Ctrl-d"    = "half_page_down";
          "Ctrl-u"    = "half_page_up";
          "Ctrl-f"    = "page_down";
          "Ctrl-b"    = "page_up";
          "/"         = "search";     # Start search
          "n"         = "search_next";
          "N"         = "search_prev";
        };
      };

      preview = {
        image_filter = "lanczos3";
        image_quality = 90;
        tab_size = 1;
        max_width = 600;
        max_height = 900;
        cache_dir = "";
        ueberzug_scale = 1;
        ueberzug_offset = [
          0
          0
          0
          0
        ];
      };

      tasks = {
        micro_workers = 5;
        macro_workers = 10;
        bizarre_retry = 5;
      };
    };
  };
}

