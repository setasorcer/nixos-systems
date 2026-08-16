{ config, lib, ... }:

let
  service = "sabnzbd";
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
      default = "${service}.${server.publicDomain}";
    };
    port = lib.mkOption {
      type = lib.types.int;
      default = 8080;
    };
  };
  config = lib.mkIf cfg.enable {
    services.${service} = {
      enable = true;
      configFile = null; # Remove disclaimer when rebuilding
      settings.misc = {
        port = cfg.port;
      };
    };
    users.users.${service}.extraGroups = [ "kyoka" ];  
    services.caddy.virtualHosts."${cfg.url}" = {
      extraConfig = ''
        reverse_proxy localhost:${toString cfg.port}
      '';
    };
  };
}
