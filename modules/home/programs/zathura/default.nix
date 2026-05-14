{ config, ... }:

{
  # Lmao
  programs.zathura = {
    enable = true;
    options = {
      default-bg = "#${config.stylix.base16Scheme.base01}";
    };
  };
}
