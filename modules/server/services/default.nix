{ config, lib, pkgs, username, ... }:

{
  options.server = {
    enable = lib.mkEnableOption "Homelab services and configuration options";
    services = {
      enable = lib.mkEnableOption "Homelab services and configuration options";
    };
    dns-refresh = {
      enable = lib.mkEnableOption "Homelab services and configuration options";
    };
    baseDomain = lib.mkOption {
      default = "";
      type = lib.types.str;
      description = ''
        Base domain used by Caddy
      '';
    };
    localDomain = lib.mkOption {
      default = "";
      type = lib.types.str;
      description = ''
        Domain name used by the local network, must include http://
      '';
    };
    dataDir = lib.mkOption {
      default = "/mnt/zichi";
      type = lib.types.path;
      description = ''
        Path to the main data storage mount
      '';
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.server.services.enable {
      networking.firewall.allowedTCPPorts = [ 80 443 ];
      # networking.firewall.allowedUDPPorts = [ ... ];
      services = {
        caddy.enable = true;
        nginx.enable = false;
        openssh = {
          enable = true;
          ports = [ 1075 ];
          settings = {
            PermitRootLogin = "no";
          AllowUsers = [ "${username}" ];
          };
        };
        endlessh = {
          enable = true;
          port = 22;
          openFirewall = true;
        };
      };
    })
    (lib.mkIf config.server.dns-refresh.enable {
      # Uses Namecheap's Dynamic DNS feature to update the IP address if it ever changes
      systemd.services.namecheap-ddns = let
        server = config.server;
      in {
        description = "Update Namecheap dynamic DNS";
        serviceConfig = {
          Type = "oneshot";
          ExecStart = pkgs.writeShellScript "update-ddns" ''
            set -e
            domain=${server.baseDomain}
            password=$(cat ${config.sops.secrets.ddns-password.path})
            for host in "@" "*"; do
              ${pkgs.curl}/bin/curl -s \
                "https://dynamicdns.park-your-domain.com/update?host=$host&domain=$domain&password=$password"
            done
          '';
        };
      };
      systemd.timers.namecheap-ddns = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnBootSec = "1min";
          OnUnitActiveSec = "10min";
        };
      };
    })
  ];

  imports = [
    ./arr/radarr
    ./arr/sonarr
    ./deluge
    ./filebrowser
    ./homepage
    ./immich
    ./jellyfin
    ./library/audiobookshelf
    ./library/komga
    ./memos
    ./miniflux
    ./sabnzbd
    #./searxng
    ./slskd
    ./vaultwarden
  ];
}
