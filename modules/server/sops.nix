{ username, config, pkgs, inputs, ... }:

{
  imports = [ inputs.sops-nix.nixosModules.default ];
  environment.systemPackages = [ pkgs.sops ];

  sops.defaultSopsFile = ./../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/${username}/.config/sops-nix/age/keys.txt";
  sops.secrets.slskd-env = {
    owner = "slskd";
    group = "slskd";
    mode = "0400"; # Only slskd can read this file
    restartUnits = [ "slskd.service" ]; # Restart slskd if secrets change
  };
  sops.secrets.glance-env = {
    owner = "root";
    group = "root";
    mode = "0400";
    restartUnits = [ "glance.service" ]; # Restart slskd if secrets change
  };
  sops.secrets.lanraragi-password = {
    owner = "lanraragi";
    group = "lanraragi";
    mode = "0400";
    restartUnits = [ "lanraragi.service" ]; # Restart slskd if secrets change
  };
  sops.secrets.porkbun-token = {};
  sops.secrets.porkbun-secret = {};
  sops.templates."acme-env".owner = "acme";
  sops.templates."acme-env".content = ''
    PORKBUN_API_KEY=${config.sops.placeholder.porkbun-token}
    PORKBUN_SECRET_API_KEY=${config.sops.placeholder.porkbun-secret}
  '';
  sops.templates."ddns-config.json".owner = "ddns-updater";
  sops.templates."ddns-config.json".content = ''
    {
      "settings": [
        {
          "provider": "porkbun",
          "domain": "${config.server.publicDomain}",
          "api_key": "${config.sops.placeholder.porkbun-token}",
          "secret_api_key": "${config.sops.placeholder.porkbun-secret}"
        },
        {
          "provider": "porkbun",
          "domain": "headscale.${config.server.publicDomain}",
          "api_key": "${config.sops.placeholder.porkbun-token}",
          "secret_api_key": "${config.sops.placeholder.porkbun-secret}"
        },
        {
          "provider": "porkbun",
          "domain": "jellyfin.${config.server.publicDomain}",
          "api_key": "${config.sops.placeholder.porkbun-token}",
          "secret_api_key": "${config.sops.placeholder.porkbun-secret}"
        },
        {
          "provider": "porkbun",
          "domain": "memos.${config.server.publicDomain}",
          "api_key": "${config.sops.placeholder.porkbun-token}",
          "secret_api_key": "${config.sops.placeholder.porkbun-secret}"
        },
        {
          "provider": "porkbun",
          "domain": "navidrome.${config.server.publicDomain}",
          "api_key": "${config.sops.placeholder.porkbun-token}",
          "secret_api_key": "${config.sops.placeholder.porkbun-secret}"
        }
      ]
    }

  '';
}
