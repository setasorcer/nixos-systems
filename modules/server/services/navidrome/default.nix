{ config, lib, pkgs, ... }:

let
  service = "navidrome";
  cfg = config.server.services.${service};
  server = config.server;
in
{
  options.server.services.${service} = {
    enable = lib.mkEnableOption {
      description = "Enable ${service}";
    };
    url = lib.mkOption {
      type = lib.types.str;
      default = "${service}.${server.publicDomain}";
    };
    port = lib.mkOption {
      type = lib.types.int;
      default = 4533;
    };
  };
  config = lib.mkIf cfg.enable {
    services.${service} = {
      enable = true;
      settings = {
        MusicFolder = "${server.dataDir}/media/music";
        Port = cfg.port;
        Address = "0.0.0.0";
        Plugins.Enabled = true;
        EnableInsightsCollector = false;
        LyricsPriority = ".ttml,.yaml,.yml,.elrc,.srt,nd-lyrics,embedded,.lrc,.txt";

        EnableStarRating = false;
        Jellyfin.Enabled = true;
      };

      plugins = with pkgs.navidromePlugins; [
        (pkgs.stdenv.mkDerivation rec {
          pname = "nd-lyrics";
          version = "8.1.0";

          src = pkgs.fetchurl {
            url = "https://github.com/J0R6IT0/navidrome-lyrics-plugin/releases/download/v8.1.0/nd-lyrics.ndp";
            hash = "sha256-Kd1XG6DUu3VuYsDVxZSi1+fJzOwpUPOwJ71kxzxgVxU=";
          };

          dontUnpack = true;

          installPhase = ''
            mkdir -p $out/share
            cp $src $out/share/nd-lyrics.ndp
          '';

          passthru = {
            isNavidromePlugin = true;
          };
        })
      ];
    };
    systemd.services.navidrome.serviceConfig.BindReadOnlyPaths = [ "${server.dataDir}/media/ost" ];
    services.caddy.virtualHosts."${cfg.url}" = {
      extraConfig = ''
        reverse_proxy localhost:${toString cfg.port}
      '';
    };  
  };
}
