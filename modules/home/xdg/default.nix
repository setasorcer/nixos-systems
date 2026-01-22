{ config, pkgs, ... }:

{
  imports = [ ./desktopEntries.nix ];

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${config.home.homeDirectory}";
      documents = "${config.home.homeDirectory}/dox";
      download = "${config.home.homeDirectory}";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pix";
      publicShare = "${config.home.homeDirectory}/dox/send";
      templates = null;
      videos = "${config.home.homeDirectory}/vid";
    };
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}
