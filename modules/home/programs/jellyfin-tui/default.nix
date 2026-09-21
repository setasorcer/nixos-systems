{ config, pkgs, ... }:

{
  sops.secrets = {
    "jellyfin-tui-password" = {};
  };
  home.packages = [ pkgs.jellyfin-tui ];
  home.file.".config/jellyfin-tui/config.yaml".text = ''
    servers:
      - name: Home Server
        password_file: ${config.sops.secrets.jellyfin-tui-password.path}
        url: https://navidrome.sakujipalace.fyi/jellyfin
        username: kanrisha
    mpv:
        replaygain: "album"

  '';
}
