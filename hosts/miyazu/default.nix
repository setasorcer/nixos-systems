{ config, pkgs, ... }:

let
  sv = config.server;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../modules/server
    ];
  
  fileSystems."/mnt/42a02f06-ecc3-4c19-b979-d92c3fe9323b" = {
    device = "/dev/disk/by-uuid/42a02f06-ecc3-4c19-b979-d92c3fe9323b";
    fsType = "ext4";
    options = [
      "nofail"
    ];
  };
  fileSystems."/mnt/zichi" = {
    device = "zichi";
    fsType = "zfs";
    options = [ "nofail" ];
  };  

  powerManagement.powertop.enable = true;

  server = {
    enable = true;
    dns-refresh.enable = true;
    baseDomain = "setasorcer.xyz";
    localDomain = "192.168.1.75";
    dataDir = "/mnt/zichi";

    services = {
      enable = true;
      radarr = {
        enable = true;
        port = 7878;
      };
      sonarr = {
        enable = true;
        port = 8989;
      };
      deluge = {
        enable = true;
        port = 8112;
      };
      filebrowser = {
        enable = true;
        port = 8089;
      };
      glance = {
        enable = true;
        port = 8087;
      };
      headscale = {
        enable = true;
        port = 8085;
      };
      homepage-dashboard = {
        enable = true;
        port = 8082;
      };
      immich = {
        enable = true;
        port = 2283;
      };
      jellyfin = {
        enable = true;
        port = 8096;
      };
      audiobookshelf = {
        enable = true;
        port = 8000;
      };
      komga = {
        enable = true;
        port = 8088;
      };
      memos = {
        enable = true;
        port = 5230;
      };
      miniflux = {
        enable = true;
        port = 8081;
      };
      sabnzbd = {
        enable = true;
        port = 8080; # Warning: does not change the actual port of sabnzbd
      };
      slskd = {
        enable = true;
        port.web = 5030;
      };
      szurubooru = {
        enable = true;
        port = 8086;
      };
      vaultwarden = {
        enable = true;
        port = 8222;
      };
    };
  };
}
