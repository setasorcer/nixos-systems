{ config, ... }:

{
  #TODO: Change db type and create database declaratively
  services.nextcloud = {
    enable = true;
    hostName = "0.0.0.0"; # Broadcast to home network
    #database.createLocally = true;
    config = {
      adminpassFile = config.sops.secrets.nextcloud-password.path;
      dbtype = "sqlite";
    };
    settings.trusted_domains = [ "192.168.1.*" ];
  };
}
