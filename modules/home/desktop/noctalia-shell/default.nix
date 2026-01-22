{ inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default

    ./colors.nix
    ./plugins.nix
  ];

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
    
  };
}
