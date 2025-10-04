{ username, pkgs, ... }:

{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "${username}";
  };
  systemd.services.jellyfin.environment.LIBVA_DRIVER_NAME = "iHD";
  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];
}
