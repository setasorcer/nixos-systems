{ config, lib, ... }:

let
  service = "seerr";
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
      default = "${service}.${server.internalDomain}";
    };
    localUrl = lib.mkOption {
      type = lib.types.str;
      default = "${server.localDomain}:${toString cfg.port}";
    };
    port = lib.mkOption {
      type = lib.types.int;
      default = 5055;
    };
  };
  config = lib.mkIf cfg.enable {
    services.${service} = {
      enable = true;
      openFirewall = true;
      port = cfg.port;
    };
    services.caddy.virtualHosts."http://${cfg.url}" = {
      extraConfig = ''
        reverse_proxy ${server.localDomain}:${toString cfg.port}
      '';
    };
  };
}
