{ config, lib, ... }:

let
  service = "lanraragi";
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
      default = 3000;
    };
  };
  config = lib.mkIf cfg.enable {
    services.${service} = {
      enable = true;
      openFirewall = true;
      port = cfg.port;
      passwordFile = config.sops.secrets.lanraragi-password.path;
    };
    services.caddy.virtualHosts."http://${cfg.url}" = {
      extraConfig = ''
        reverse_proxy ${server.localDomain}:${toString cfg.port}
      '';
    };
    systemd.services.lanraragi.serviceConfig.ReadWritePaths = [
      "${server.dataDir}/library/doujinshi"
    ];
    users.groups.${service} = {};
    users.users.${service} = {
      isSystemUser = true;
      group = "${service}";
    };
  };
}
