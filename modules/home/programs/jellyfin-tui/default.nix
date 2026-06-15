{ config, pkgs, ... }:

{
  sops.secrets."jellyfin-tui-password" = {};
  home.packages = [ pkgs.jellyfin-tui ];
  home.file.".config/jellyfin-tui/config.yaml".text = ''
    servers:
      - name: miyazu
        password_file: ${config.sops.secrets.jellyfin-tui-password.path}
        url: https://jellyfin.setasorcer.xyz
        username: hori
    mpv:
        replaygain: "album"
    discord: 1053747938519679018
    discord_art: "local"
    discord_status: "state"

  '';
}
