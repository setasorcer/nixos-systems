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
      default = "${service}.${server.publicDomain}";
    };
    port = lib.mkOption {
      type = lib.types.int;
      default = 3000;
    };
  };
  config = lib.mkIf cfg.enable {
    services.${service} = {
      enable = true;
      port = cfg.port;
      passwordFile = config.sops.secrets.lanraragi-password.path;
    };
    services.caddy.virtualHosts."${cfg.url}" = {
      extraConfig = ''
        reverse_proxy localhost:${toString cfg.port}

        tls /var/lib/acme/${server.publicDomain}/cert.pem /var/lib/acme/${server.publicDomain}/key.pem {
          protocols tls1.3
        }
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
