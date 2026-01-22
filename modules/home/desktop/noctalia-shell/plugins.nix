{ config, ... }:

{
  programs.noctalia-shell = {
    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        privacy-indicator = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        screen-recorder = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
      version = 1;
    };
    pluginSettings = {
      privacy-indicator = {
        hideInactive = true;
        iconSpacing = 4;
        removeMargins = false;
      };
      screen-recorder = {
        directory = "${config.home.homeDirectory}/pix/snaps";
        filenamePattern = "yyyy-MM-dd_recording_HHmmss_niri";
        frameRate = 30;
        audioCodec = "opus";
        videoCodec = "h264";
        quality = "medium";
        colorRange = "limited";
        showCursor = true;
        copyToClipboard = true;
        audioSource = "default_output";
        videoSource = "portal";
        resolution = "1920x1080";
      };
    };
  };
}
