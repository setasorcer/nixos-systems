{ username, pkgs, inputs, config, ... }:

{
  imports = [ inputs.sops-nix.nixosModules.default ];
  environment.systemPackages = [ pkgs.sops ];

  sops.defaultSopsFile = ./../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/${username}/.config/sops/age/keys.txt";

  sops.secrets."jellyfin-rpc-apikey" = {};
  sops.templates."jellyfin-rpc-config" = {
    content = ''
      {
        "jellyfin": {
            "url": "https://jellyfin.setasorcer.xyz",
            "api_key": "${config.sops.placeholder.jellyfin-rpc-apikey}",
            "username": ["hori"],
            "music": {
                "display": {
                    "details_text": "{track}",
                    "state_text": "{artists}",
                    "image_text": "{album}"
                },
                "separator": "-"
            }
            "blacklist": {
              "libraries": ["Books"]
            }
        },
        "discord": {
            "application_id": "1053747938519679018",
            "buttons": [
                {
                    "name": "dynamic",
                    "url": "dynamic"
                },
                {
                    "name": "dynamic",
                    "url": "dynamic"
                }
            ]
        },
        "images": {
            "enable_images": true,
            "imgur_images": false
        }
      }
    '';
    path = "/home/${username}/.config/jellyfin-rpc/main.json";
    owner = "${username}";
    group = "users";
    mode = "0400";
  };
  sops.secrets."jellyfin-tui-password" = {};
  sops.templates."jellyfin-tui-config" = {
    content = ''
      servers:
        - name: miyazu
          password: ${config.sops.placeholder.jellyfin-tui-password}
          url: https://jellyfin.setasorcer.xyz
          username: hori
      mpv:
          replaygain: "album"
    '';
    path = "/home/${username}/.config/jellyfin-tui/config.yaml";
    owner = "${username}";
    group = "users";
    mode = "0400";
  };
  systemd.tmpfiles.rules = [
    "d /home/${username}/.config/jellyfin-tui 0755 ${username} users - -"
    "d /home/${username}/.config/jellyfin-rpc 0755 ${username} users - -"
  ];
}
