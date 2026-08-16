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
    publicDomain = lib.mkOption {
      default = "";
      type = lib.types.str;
      description = ''
        Base domain used by Caddy
      '';
    };
    localAddress = lib.mkOption {
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
      # Self-signed local HTTPS certificates with ACME
      security.acme = {
        acceptTerms = true;
        defaults.email = "admin@sakujipalace.fyi";

        certs."${config.server.publicDomain}" = {
          group = config.services.caddy.group;
          domain = config.server.publicDomain;
          extraDomainNames = [ "*.${config.server.publicDomain}" ];

          dnsProvider = "porkbun";
          dnsResolver = "${toString config.server.localAddress}:53";
          dnsPropagationCheck = false;

          environmentFile = config.sops.templates."acme-env".path;
        };
      };
      services = {
        caddy.enable = true;
        nginx.enable = false;
        openssh = {
          enable = true;
          ports = [ 22 ];
          settings = {
            PermitRootLogin = "no";
          AllowUsers = [ "${username}" ];
          };
        };
      };
    })
    (lib.mkIf config.server.dns-refresh.enable {
      services.ddns-updater = {
        enable = true;
        environment = {
          SERVER_ENABLED = "no";
          CONFIG_FILEPATH = config.sops.templates."ddns-config.json".path;
          PERIOD = "5m";
        };
      };
      users.groups.ddns-updater = {};
      users.users.ddns-updater = {
        isSystemUser = true;
        group = "ddns-updater";
      };
    })
  ];

  imports = [
    ./arr/radarr
    ./arr/sonarr
    ./glance
    ./immich
    ./jellyfin
    ./lanraragi
    ./memos
    ./navidrome
    ./opencloud
    ./pihole
    ./radicale
    ./sabnzbd
    ./slskd
    ./vaultwarden
    ./vpn/headscale
    ./vpn/tailscale
  ];
}
