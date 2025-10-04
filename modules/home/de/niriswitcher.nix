{ config, pkgs, ... }:

{
  home.packages = [ pkgs.glib ];
  programs.niriswitcher = {
    enable = true;
    settings = {
      keys = {
        modifier = "Super";
        switch = {
          next = "l";
          prev = "h";
        };
        workspace = {
          next = "k";
          prev = "j";
        };
      };
    };
  };
    
  programs.niri.settings.binds = with config.lib.niri.actions; {
    "Mod+Tab".action = spawn "gdbus" "call" "--session" "--dest" "io.github.isaksamsten.Niriswitcher" "--object-path" "/io/github/isaksamsten/Niriswitcher" "--method" "io.github.isaksamsten.Niriswitcher.application";
    "Mod+Tab".repeat = false;
    "Mod+Shift+Tab".action = spawn "gdbus" "call" "--session" "--dest" "io.github.isaksamsten.Niriswitcher" "--object-path" "/io/github/isaksamsten/Niriswitcher" "--method" "io.github.isaksamsten.Niriswitcher.application";
    "Mod+Shift+Tab".repeat = false;
  };
}
