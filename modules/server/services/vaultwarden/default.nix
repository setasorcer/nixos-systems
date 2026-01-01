{ config, lib, ... }:

let
  service = "vaultwarden";
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
      default = "bitwarden.${server.baseDomain}";
    };
    port = lib.mkOption {
      type = lib.types.int;
      default = 8222;
    };
  };
  config = lib.mkIf cfg.enable {
    services.${service} = {
      enable = true;
      config = {
        DOMAIN = "https://${cfg.url}";
        SIGNUPS_ALLOWED = false;

        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = cfg.port;
        ROCKET_LOG = "critical";
      };
    };
    services.caddy.virtualHosts."${cfg.url}" = {
      extraConfig = ''
        encode zstd gzip

        reverse_proxy localhost:${toString cfg.port} {
          header_up X-Real-IP {remote_host}
        }
      '';
    };
  };
}
