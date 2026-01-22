{ config, lib, ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        pad = "24x24";
      };
      colors = {
        background = lib.mkForce "${config.stylix.base16Scheme.base01}";
      };
    };
  };
}
