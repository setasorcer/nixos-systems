{ config, lib, ... }:

let
  service = "szurubooru";
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
      default = "${service}.${server.baseDomain}";
    };
    port = lib.mkOption {
      type = lib.types.int;
      default = 8086;
    };
  };
  config = lib.mkIf cfg.enable {
    services.${service} = {
      enable = true;
      openFirewall = true;
      server = {
        port = cfg.port;
        settings = {
          #domain = "https://${cfg.url}";
          domain = "http://0.0.0.0:${toString cfg.port}";
          #data_dir = "${server.dataDir}/files/${service}";
          secretFile = config.sops.secrets.szurubooru-secret.path;
        };
      };
      database.passwordFile = config.sops.secrets.szurubooru-password.path;
    };
    services.caddy.virtualHosts."${cfg.url}" = {
      extraConfig = ''
        # Proxy API requests – strip /api prefix
        handle_path /api/* {
          reverse_proxy {
            to http://localhost:${toString cfg.port}
            transport http {
              dial_timeout 10s
              response_header_timeout 30s
            }
          }
        }

        # Serve uploaded data files
        handle /data/* {
          root * ${config.services.szurubooru.dataDir}
          file_server
        }

        # Serve frontend SPA
        handle {
          root * ${config.services.szurubooru.client.package}
          try_files {path} /index.htm
          file_server
        }
      '';
    };  
  };
}
