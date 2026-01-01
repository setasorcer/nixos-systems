{ config, ... }:

{
  services.searx = {
    enable = true;
    redisCreateLocally = true;
    environmentFile = config.sops.secrets.searxng-secret.path;
    settings.server = {
      bind_address = "::1";
      port = 8091;
    };
  };
  services.caddy.virtualHosts."searx.setasorcer.xyz" = {
    extraConfig = ''
      reverse_proxy localhost:8091
    '';
  };  
}
