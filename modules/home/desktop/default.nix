{ lib, pkgs, ... }:

{
  imports = [
    ./niri
    ./noctalia
    ./umbriel
  ];

  stylix = {
    targets = {
      fcitx5.enable = true;
      gtk.enable = true;
    };
    icons = {
      enable = true;
      package = lib.mkForce pkgs.adwaita-icon-theme;
      light = "adwaita";
      dark = "adwaita-dark";
    };
  };
  gtk = {
    enable = true;
    iconTheme = {
      package = lib.mkForce pkgs.adwaita-icon-theme;
      name = lib.mkForce "Adwaita";
    };
  };
  home.pointerCursor = {
    enable = true;
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePineDawn-Linux";
    size = 32;
  };
}
