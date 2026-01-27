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
      server = {
        port = cfg.port;
        settings = {
          domain = cfg.url;
          data_url = "${server.dataDir}/files/${service}";
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
