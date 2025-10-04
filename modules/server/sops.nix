{ username, pkgs, inputs, ... }:

{
  imports = [ inputs.sops-nix.nixosModules.default ];
  environment.systemPackages = [ pkgs.sops ];

  sops.defaultSopsFile = ./../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.secrets.nextcloud-password = { };
  sops.age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
}
