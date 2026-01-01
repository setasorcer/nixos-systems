{ config, lib, ... }:

let
  service = "deluge";
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
      default = 8112;
    };
  };
  config = lib.mkIf cfg.enable {
    services.${service} = {
      enable = true;
      web = {
        enable = true;
        port = cfg.port;
        openFirewall = true;
      };
    };

    users.users.${service}.extraGroups = [ "kyoka" ];
  };
}
