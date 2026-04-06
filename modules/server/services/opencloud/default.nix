{ config, lib, ... }:

let
  service = "opencloud";
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
      default = "cloud.${server.baseDomain}";
    };
    port = lib.mkOption {
      type = lib.types.int;
      default = 9200;
    };
  };
  config = lib.mkIf cfg.enable {
    services.${service} = {
      enable = true;

      address = "0.0.0.0";
      stateDir = "${server.dataDir}/files/cloud";
      port = cfg.port;
      url = "https://${server.baseDomain}:${toString cfg.port}";
      environment = {
        PROXY_TLS = "false";
        OC_URL = "https://${cfg.url}";
      };
    };
    networking.firewall.allowedTCPPorts = [ cfg.port ];
    services.caddy.virtualHosts."${cfg.url}" = {
      extraConfig = ''
        reverse_proxy localhost:${toString cfg.port}
      '';
    };

  };
}
