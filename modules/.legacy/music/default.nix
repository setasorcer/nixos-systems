{ pkgs, ... }:

{
  imports = [ ./ncmpcpp.nix ];
  # Utilities for music
  home.packages = with pkgs; [
    mpc # mpd CLI
    playerctl # mpris CLI
    rsgain # ReplayGain tool
    picard # Metatag editor
    nicotine-plus # Legal music sharing
    plattenalbum # GTK interface for mpd
    jamesdsp # EQ
  ];
  services = {
    mpd = {
      enable = true;
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
    mpd-mpris.enable = true;
  };
}
