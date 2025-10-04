{ pkgs, ... }:

{
  #imports = [ ./ncmpcpp.nix ];
  # Utilities for music
  home.packages = with pkgs; [
    #mpc # mpd CLI
    playerctl # mpris CLI
    rsgain # ReplayGain tool
    #kid3-qt # Metatag editor
    nicotine-plus # Hehehe
    #plattenalbum # GTK interface for mpd
    #jamesdsp # EQ
    feishin
  ];
  services = {
    mpd = {
      enable = false;
      # Pipewire support
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "My PipeWire Output"
        }
        replaygain "album"
      '';
    };
    # MPRIS support
    mpd-mpris.enable = false;
  };
}
