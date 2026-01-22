{ lib, pkgs, ... }:

{
  imports = [
    ./niri
    ./noctalia-shell
  ];

  stylix = {
    targets = {
      btop.enable = true;
      fcitx5.enable = true;
      zen-browser.enable = true;
      zen-browser.profileNames = [ "default" ];
      foot.enable = true;
      gtk.enable = true;
      gtk.flatpakSupport.enable = true;
      nvf.enable = true;
      nvf.transparentBackground.main = true;
      yazi.enable = true;
    };
    icons = {
      enable = true;
      package = lib.mkForce pkgs.adwaita-icon-theme;
      light = "adwaita";
      dark = "adwaita-dark";
    };
  };
  gtk.enable = true;

}
