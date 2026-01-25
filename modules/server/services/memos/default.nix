{ config, lib, pkgsUnstable, ... }:

let
  service = "memos";
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
      default = "memos.${server.baseDomain}";
    };
    port = lib.mkOption {
      type = lib.types.int;
      default = 5230;
    };
  };
  config = lib.mkIf cfg.enable {
    services.${service} = {
      enable = true;
      package = pkgsUnstable.${service};
      settings = {
        MEMOS_MODE = "prod";
        MEMOS_ADDR = "127.0.0.1";
        MEMOS_PORT = "${toString cfg.port}";
        MEMOS_DATA = config.services.memos.dataDir;
        MEMOS_DRIVER = "sqlite";
        MEMOS_INSTANCE_URL = "http://localhost:${toString cfg.port}";
      };
      dataDir = "${server.dataDir}/media/notes/";
    };
    services.caddy.virtualHosts."${cfg.url}" = {
      extraConfig = ''
        reverse_proxy localhost:${toString cfg.port}
      '';
    };  
  };
}
