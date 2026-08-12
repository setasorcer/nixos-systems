{ config, ... }:

{
  programs.zathura = {
    enable = true;
    options = {
      default-bg = "${config.lib.stylix.colors.withHashtag.base01}";
    };
  };
}
