{ config, inputs, pkgs, ... }:

{
  imports = [ inputs.sops-nix.homeManagerModules.sops ];
  home.packages = [ pkgs.sops ];

  sops.defaultSopsFile = ./../../../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
}
