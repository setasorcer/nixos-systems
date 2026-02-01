{ host, config, lib, ... }:

let
  service = "glance";
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
      default = 8087;
    };
  };
  config = lib.mkIf cfg.enable {
    services.${service} = {
      enable = true;
      environmentFile = config.sops.secrets.glance-env.path;

      settings = {
        server.port = cfg.port;
        auth = {
          secret-key = "\${GLANCE_SECRET_KEY}";
          users.admin.password = "\${GLANCE_USER_PASSWORD}";
        };
        pages = [
          {
            name = "Home";
            # hide-desktop-navigation = true;  # Optional: uncomment if needed
            
            columns = [
              {
                size = "small";
                widgets = [
                  {
                    type = "server-stats";
                    servers = [
                      {
                        type = "local";
                        name = "${host}";
                        hide-mountpoints-by-default = true;
                        mountpoints = {
                          "/".hide = false;
                          "${server.dataDir}".hide = false;
                        };
                      }
                    ];
                  }
                  {
                    type = "monitor";
                    cache = "1m";
                    title = "Entertainment";
                    sites = [
                      {
                        title = "Jellyfin";
                        url = "https://${server.services.jellyfin.url}";
                        icon = "di:jellyfin";
                      }
                      {
                        title = "Audiobookshelf";
                        url = "http://${server.services.audiobookshelf.url}";
                        icon = "di:audiobookshelf";
                      }
                      {
                        title = "Komga";
                        url = "http://${server.services.komga.url}";
                        icon = "di:komga";
                      }
                    ];
                  }
                  {
                    type = "monitor";
                    cache = "1m";
                    title = "Storage";
                    sites = [
                      {
                        title = "Memos";
                        url = "https://${server.services.memos.url}";
                        icon = "di:memos";
                      }
                      {
                        title = "File Browser";
                        url = "http://${server.services.filebrowser.url}";
                        icon = "di:filebrowser";
                      }
                      {
                        title = "Immich";
                        url = "http://${server.services.immich.url}";
                        icon = "di:immich";
                      }
                      {
                        title = "Vaultwarden";
                        url = "https://${server.services.vaultwarden.url}";
                        icon = "di:vaultwarden";
                      }
                    ];
                  }
                  {
                    type = "monitor";
                    cache = "1m";
                    title = "File Sharing";
                    sites = [
                      {
                        title = "Radarr";
                        url = "http://${server.services.radarr.url}";
                        icon = "di:radarr";
                      }
                      {
                        title = "Sonarr";
                        url = "http://${server.services.sonarr.url}";
                        icon = "di:sonarr";
                      }
                      {
                        title = "Sabnzbd";
                        url = "http://${server.services.sabnzbd.url}";
                        icon = "di:sabnzbd";
                      }
                      {
                        title = "Slskd";
                        url = "http://${server.services.slskd.url}";
                        icon = "di:slskd";
                      }
                    ];
                  }
                ];
              }
              {
                size = "full";
                widgets = [
                  {
                    type = "videos";
                    include-shorts = true;
                    channels = [
                      "UCMMYpCFKYv0q8jQO53-vs1g"  # ADOCLIPS
                      "UCYZtp0YIxYOipX15v_h_jnA"  # Crowbcat
                      "UC7Ucs42FZy3uYzjrqzOIHsw"  # EmpLemon
                      "UC2_krAagEXVPftDXZCDiVZA"  # Kaname Naito
                      "UCXZ0aTkZAQGS4fgD1jvG2gg"  # kettletoro
                      "UCiWd1l8UQaz9_LKw7RT8JOQ"  # kettleuma
                      "UC4KZhRZ2iYC9Jnjx2jxHPdQ"  # murau
                    ];
                  }
                  {
                    type = "videos";
                    style = "grid-cards";
                    collapse-after-rows = 3;
                    channels = [
                      "UCRYeRa2iUMd8An1WTPIP2bw"  # aChair Leg
                      "UCWFNUk2LHUQdRzQcJLYZmcg"  # Bringus Studios
                      "UCDXpP3bwWjhjBRdCP-5mNVg"  # Daihuku Keyboard
                      "UCR-DXc1voovS8nhAvccRZhg"  # Jeff Geerling
                      "UCJXa3_WNNmIpewOtCHf3B0g"  # LaurieWired
                      "UCXuqSBlHAE6Xw-yeJA0Tunw"  # Linus Tech Tips
                      "UCBJycsmduvYEL83R_U4JriQ"  # Marques Brownlee
                      "UC7YOGHUfC1Tb6E4pudI9STA"  # Mental Outlaw
                      "UCRjUOplWHoZ7zfl9ZVHgIVA"  # Milktooth
                      "UCHnyfMqiRRG1u-2MsSQLbXA"  # Veritasium
                      "UC_zBdZ0_H_jn41FDRG7q4Tw"  # Vimjoyer
                    ];
                  }
                  {
                    type = "group";
                    widgets = [
                      { type = "hacker-news"; }
                      { type = "lobsters"; }
                    ];
                  }
                ];
              }
              {
                size = "small";
                widgets = [
                  {
                    type = "rss";
                    limit = 10;
                    collapse-after = -1;
                    cache = "12h";
                    feeds = [
                      {
                        url = "https://discourse.nixos.org/c/announcements/8.rss";
                        title = "NixOS Announcements";
                      }
                      {
                        url = "https://store.steampowered.com/feeds/news/group/45479024/?cc=US&l=english";
                        title = "Steam Hardware";
                      }
                      {
                        url = "https://selfh.st/rss/";
                        title = "selfh.st";
                        limit = 4;
                      }
                    ];
                  }
                  /*{
                    type = "releases";
                    cache = "1d";
                    # token = "...";  # Optional: add GitHub token if needed
                    repositories = [
                      "glanceapp/glance"
                      "go-gitea/gitea"
                      "immich-app/immich"
                      "syncthing/syncthing"
                    ];
                  }*/
                ];
              }
            ];
          }
        ];
      };
    };
    services.caddy.virtualHosts."${cfg.url}" = {
      extraConfig = ''
        reverse_proxy localhost:${toString cfg.port}
      '';
    };  
  };
}
