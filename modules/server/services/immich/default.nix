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
      default = "${server.localDomain}:${toString cfg.port}";
    };
    port = lib.mkOption {
      type = lib.types.int;
      default = 2283;
    };
  };
  config = lib.mkIf cfg.enable {
    services.${service} = {
      enable = true;
      openFirewall = true;
      host = "0.0.0.0";
      port = cfg.port;
      mediaLocation = "${server.dataDir}/immich";
      accelerationDevices = [ "/dev/dri/renderD128" ];
    };
    users.users.${service}.extraGroups = [ "video" "render" ];
  };
}
