{ config, lib, ... }:

let
  service = "miniflux";
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
      default = "rss.${server.baseDomain}";
    };
    port = lib.mkOption {
      type = lib.types.int;
      default = 8081;
    };
  };
  config = lib.mkIf cfg.enable {
    services.${service} = {
      enable = true;
      config = {
        BASE_URL = "https://${cfg.url}";
        CREATE_ADMIN = true;
        LISTEN_ADDR = "localhost:${toString cfg.port}";
      };
      adminCredentialsFile = config.sops.secrets.miniflux-admin-credentials.path;
    };
    # Create persistent group and user
    users.users.${service} = {
      isSystemUser = true;
      group = "${service}";
      home = "/var/lib/${service}";
    };
    users.groups.${service} = {};
    
    # 2. Override the service to use static user
    systemd.services.${service}.serviceConfig = {
      DynamicUser = lib.mkForce false;
      User = "${service}";
      Group = "${service}";
      StateDirectory = "${service}";  # Creates /var/lib/miniflux
    };

    services.caddy.virtualHosts."${cfg.url}" = {
      extraConfig = ''
        reverse_proxy localhost:${toString cfg.port}
      '';
    };
  };
}
