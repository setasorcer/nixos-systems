{ config, lib, ... }:

let
  service = "immich";
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
      default = 2283;
    };
  };
  config = lib.mkIf cfg.enable {
    services.${service} = {
      enable = true;
      host = "0.0.0.0";
      port = cfg.port;
      mediaLocation = "${server.dataDir}/immich";
      accelerationDevices = [ "/dev/dri/renderD128" ];
    };
    users.users.${service}.extraGroups = [ "video" "render" ];
    services.caddy.virtualHosts."${cfg.url}" = {
      extraConfig = ''
        reverse_proxy localhost:${toString cfg.port}
      '';
    };
  };
}
