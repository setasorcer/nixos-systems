{ config, lib, ... }:

let
  service = "radicale";
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
      default = 5232;
    };
  };
  config = lib.mkIf cfg.enable {
    services.${service} = {
      enable = true;
      settings = {
        server.hosts = [ "0.0.0.0:${toString cfg.port}" ];
        auth.type = "none";
        storage.filesystem_folder = "${server.dataDir}/files/cal";
      };
    };
    services.caddy.virtualHosts."http://${cfg.url}" = {
      extraConfig = ''
        reverse_proxy ${server.localDomain}:${toString cfg.port}
      '';
    };
  };
}
