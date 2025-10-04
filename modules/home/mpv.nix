{ config, pkgs, ... }:

{
  programs.mpv = {
    enable = true;
    bindings = {
      RIGHT = "seek 5";
      LEFT = "seek -5";
      "shift+RIGHT" = "seek 1";
      "shift+LEFT" = "seek -1";
      "shift+UP" = "seek 10";
      "shift+DOWN" = "seek -10";
      "[" = "add speed -0.1";
      "]" = "add speed 0.1";
      "alt+H" =  "script-binding mpvacious-sub-seek-back";
      "alt+L" =  "script-binding mpvacious-sub-seek-forward";
      "L" = "cycle-values loop-file inf no";
    };
    extraInput = ''
      Alt+RIGHT no-osd cycle-values video-rotate "90" "180" "270" "0"
      Alt+LEFT no-osd cycle-values video-rotate "270" "180" "90" "0"
    '';

    scripts = with pkgs.mpvScripts; [
      modernx
      thumbfast
      videoclip
      mpris
      mpvacious
    ];
    config = {
      hwdec = "vulkan";
      vo = "gpu";
      osc = "no";
      border = "no";

      osd-scale = "0.5";
      osd-outline-size = "0.4";
      osd-blur = "0.4";
    };
    scriptOpts = {
      osc = {
        scalewindowed = "0.5";
        scalefullscreen = "0.5";
        windowcontrols = "no";
      };
      videoclip = {
        video_folder_path = "${config.home.homeDirectory}";
      };
    };
  };
}
