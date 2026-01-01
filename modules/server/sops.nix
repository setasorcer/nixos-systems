{ username, pkgs, inputs, ... }:

{
  imports = [ inputs.sops-nix.nixosModules.default ];
  environment.systemPackages = [ pkgs.sops ];

  sops.defaultSopsFile = ./../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
  sops.secrets.slskd-env = {
    owner = "slskd";
    group = "slskd";
    mode = "0400"; # Only slskd can read this file
    restartUnits = [ "slskd.service" ]; # Restart slskd if secrets change
  };
  sops.secrets.miniflux-admin-credentials = {
    owner = "miniflux";
    group = "miniflux";
    path = "/var/lib/miniflux/admin-credentials";
    mode = "0400";
    restartUnits = [ "miniflux.service" ];
  };
  /*sops.secrets.searxng-secret = {
    owner = "searx";
    group = "searx";
    mode = "0400";
    restartUnits = [ "searx.service" ];
  };*/
  sops.secrets.ddns-password = {
    owner = "root";
    group = "root";
    mode = "0400";
    restartUnits = [ "namecheap-ddns.service" ];
  };
}
