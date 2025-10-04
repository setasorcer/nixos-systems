{ pkgs, inputs, ... }:

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
    # Mountain colour scheme by gnsfujiwara
    base16Scheme = {
      base00 = "0f0f0f";
      base01 = "191919";
      base02 = "262626";
      base03 = "393939";
      base04 = "4c4c4c";
      base05 = "cacaca";
      base06 = "e7e7e7";
      base07 = "f0f0f0";
      base08 = "ac8a8c";
      base09 = "ceb188";
      base0A = "aca98a";
      base0B = "8aac8b";
      base0C = "8aabac";
      base0D = "8f8aac";
      base0E = "ac8aac";
      base0F = "ac8a8c";
    };
    image = ./../../../papes/pape.jpg;
    polarity = "dark";
    # Waybar
    opacity.desktop = 0.7;
    # Swaync, avizo, rofi
    opacity.popups = 0.9;
    opacity.terminal = 0.9;
    opacity.applications = 0.8;
    fonts.monospace = {
      package = pkgs.nerd-fonts.inconsolata;
      name = "Inconsolata Nerd Font Mono";
    };
    cursor = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePineDawn-Linux";
      size = 28;
    };
  };
}
