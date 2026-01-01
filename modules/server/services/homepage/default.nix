{ config, lib, ... }:

let
  service = "homepage-dashboard";
  cfg = config.server.services.${service};
  server = config.server;
in
{
  options.server.services.${service} = {
    enable = lib.mkEnableOption {
      description = "Enable ${service}";
    };
    url = lib.mkOption {
      type = lib.types.str;
      default = server.baseDomain;
    };
    port = lib.mkOption {
      type = lib.types.int;
      default = 8082;
    };
  };
  config = lib.mkIf cfg.enable {
    services.${service} = {
      enable = true;
      listenPort = cfg.port;
      allowedHosts = server.baseDomain;
      settings = {
        title = "Den of Setasorcer";
      };
      widgets = [
        {
          resources = {
            cpu = true;
            disk = server.dataDir;
            memory = true;
          };
        }
      ];
      services = [
        {
          "Media" = [
            {
              "File Browser" = {
                description = "Web file manager";
                href = "http://${server.services.filebrowser.url}";
                siteMonitor = "http://${server.services.filebrowser.url}";
                icon = "filebrowser.png";
              };
            }{
              "Immich" = {
                description = "Self-hosted photo and video management solution";
                href = "http://${server.services.immich.url}";
                siteMonitor = "http://${server.services.immich.url}";
                icon = "immich.png";
              };
            }{
              "Jellyfin" = {
                description = "The free software media system";
                href = "https://${server.services.jellyfin.url}";
                siteMonitor = "https://${server.services.jellyfin.url}";
                icon = "jellyfin.png";
              };
            }
          ];
        }
        {
          "Reading" = [
            {
              "Audiobookshelf" = {
                description = "Self-hosted audiobook and podcast server";
                href = "http://${server.services.audiobookshelf.url}";
                siteMonitor = "http://${server.services.audiobookshelf.url}";
                icon = "audiobookshelf.png";
              };
            }{
              "Komga" = {
                description = "Free and open source comics/mangas media server";
                href = "http://${server.services.komga.url}";
                siteMonitor = "http://${server.services.komga.url}";
                icon = "komga.png";
              };
            }{
              "Memos" = {
                description = "Open source, self-hosted note taking";
                href = "https://${server.services.memos.url}";
                siteMonitor = "https://${server.services.memos.url}";
                icon = "memos.png";
              };
            }{
              "Miniflux" = {
                description = "Minimalist and opinionated feed reader";
                href = "https://${server.services.miniflux.url}";
                siteMonitor = "https://${server.services.miniflux.url}";
                icon = "miniflux.png";
              };
            }
          ];
        }
        {
          "*Arrs" = [
            {
              "Radarr" = {
                description = "See all your upcoming movies in one convenient location";
                href = "http://${server.services.radarr.url}";
                siteMonitor = "http://${server.services.radarr.url}";
                icon = "radarr.png";
              };
            }{
              "Sonarr" = {
                description = "An internet PVR for Usenet and Torrents";
                href = "http://${server.services.sonarr.url}";
                siteMonitor = "http://${server.services.sonarr.url}";
                icon = "sonarr.png";
              };
            }
          ];
        }
        {
          "Utilities" = [
            {
              "Vaultwarden" = {
                description = "Unofficial Bitwarden server in Rust";
                href = "https://${server.services.vaultwarden.url}";
                siteMonitor = "https://${server.services.vaultwarden.url}";
                icon = "vaultwarden.png";
              };
            }
          ];
        }
        {
          "Downloaders" = [
            {
              "Deluge" = {
                description = "A lightweight, Free Software, cross-platform BitTorrent client";
                href = "http://${server.services.deluge.url}";
                siteMonitor = "http://${server.services.deluge.url}";
                icon = "deluge.png";
              };
            }{
              "Sabnzbd" = {
                description = "The free and easy binary newsreader";
                href = "http://${server.services.sabnzbd.url}";
                siteMonitor = "http://${server.services.sabnzbd.url}";
                icon = "sabnzbd.png";
              };
            }{
              "Slskd" = {
                description = "A modern client-server application for the Soulseek file sharing network";
                href = "http://${server.services.slskd.url}";
                siteMonitor = "http://${server.services.slskd.url}";
                icon = "slskd.png";
              };
            }
          ];
        }
      ];
    };
    services.caddy.virtualHosts."${server.services.homepage-dashboard.url}" = {
      extraConfig = ''
        reverse_proxy localhost:${toString cfg.port}
      '';
    };
  };
}
