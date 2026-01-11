{ config, lib, ... }:

let
  service = "slskd";
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
      default = "${server.localDomain}:${toString cfg.port.web}";
    };
    port.web = lib.mkOption {
      type = lib.types.int;
      default = 5030;
    };
    port.listen = lib.mkOption {
      type = lib.types.int;
      default = 50300;
    };
  }; 
  config = lib.mkIf cfg.enable {
    services.${service} = {
      enable = true;
      environmentFile = config.sops.secrets.slskd-env.path;
      domain = null;
      settings = {
        shares.directories = [
          "${server.dataDir}/media/music"
          "${server.dataDir}/media/ost"
        ];
        #directories.downloads = "/mnt/zichi/media/music/picard";
        web.port = cfg.port.web;
        soulseek.listen_port = cfg.port.listen;
      };
    };
    # NOTE: Test if the web port works locally, I would prefer not hosting slskd's web service publicly and instead using my todo list to make artist/album requests
    /*services.caddy.virtualHosts."slskd.setasorcer.xyz" = {
      extraConfig = ''
        reverse_proxy localhost:${toString port}
      '';
    };*/  
    
    # Almost forgot this lmao
    networking.firewall.allowedTCPPorts = [ cfg.port.web cfg.port.listen ];
    users.users.${service}.extraGroups = [ "kyoka" ];
  };
}
