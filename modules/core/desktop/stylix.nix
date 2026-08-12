{ lib, inputs, pkgs, ... }:

{
  imports = [ inputs.stylix.nixosModules.stylix ];
  stylix = {
    enable = true;
    autoEnable = false;
    targets = {
      console.enable = true;
      fish.enable = true;
      gtk.enable = true;
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/mountain.yaml";
    image = lib.mkDefault ./../../../papes/pape.jpg;
    polarity = "dark";
    # Waybar
    opacity.desktop = 0.7;
    # Swaync, avizo, rofi
    opacity.popups = 0.9;
    opacity.terminal = 0.9;
    opacity.applications = 0.8;
  };
}
