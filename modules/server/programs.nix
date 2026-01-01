{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nnn
    btop
    smartmontools
  ];
  programs = {
    nano.enable = false;
    neovim = {
      enable = true;
      configure = {
        customRC = ''
          set rnu
        '';
      };
    };
  };
}
