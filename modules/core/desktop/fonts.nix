{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.inconsolata
    aileron
    noto-fonts-cjk-sans
  ];

  stylix = {
    fonts = {
      serif = config.stylix.fonts.sansSerif;
      sansSerif = {
        package = pkgs.nerd-fonts.inconsolata;
        name = "Inconsolata Nerd Font Mono";
      };
      monospace = {
        package = pkgs.nerd-fonts.inconsolata;
        name = "Inconsolata Nerd Font Mono";
      };
      /*emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };*/
    };
  };
}
