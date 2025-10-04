{ ... }:

{
  services.immich = {
    enable = true;
    openFirewall = true;
    host = "0.0.0.0";
    mediaLocation = "/mnt/42a02f06-ecc3-4c19-b979-d92c3fe9323b/immich";
    accelerationDevices = [ "/dev/dri/renderD128" ];
  };
  users.users.immich.extraGroups = [ "video" "render" ];
}
