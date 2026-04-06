{ config, lib, ... }:

let
  service = "vikunja";
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
      default = "vikunja.${server.baseDomain}";
    };
    port = lib.mkOption {
      type = lib.types.int;
      default = 3456;
    };
  };
  config = lib.mkIf cfg.enable {
    services.${service} = {
      enable = true;
      settings = {
        service.enableregistration = false;
      };
      #database.path = "${server.dataDir}/media/tasks";
      frontendScheme = "https";
      frontendHostname = cfg.url;
    };
    services.caddy.virtualHosts."${cfg.url}" = {
      extraConfig = ''
        reverse_proxy localhost:${toString cfg.port}
      '';
    };  
  };
}
