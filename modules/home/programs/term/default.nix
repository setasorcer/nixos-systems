{ config, lib, ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        pad = "24x24";
      };
    };
  };
}
