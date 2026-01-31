{ config, lib, ... }:

let
  service = "headscale";
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
      default = 8085;
    };
  };
  config = lib.mkIf cfg.enable {
    services.${service} = {
      enable = true;

      port = cfg.port;
      settings = {
        server_url = "https://${cfg.url}";
        dns = {
          base_domain = server.internalDomain;
          nameservers.global = [ "1.1.1.1" "8.8.8.8" ];
        };
      };
    };
    services.caddy.virtualHosts."${cfg.url}" = {
      extraConfig = ''
        reverse_proxy localhost:${toString cfg.port}
      '';
    };  
  };
}
