{ pkgs, config, lib, ... }:

let
  cfg = config.desktop.games;
in
{
  options.desktop = {
    games = {
      steam.enable = lib.mkEnableOption "Enable installation of Steam and other related utilities";
      prismlauncher.enable = lib.mkEnableOption "Enable Prism Launcher, a Minecraft launcher";
      retroarch = {
        enable = lib.mkEnableOption "Enable RetroArch multi-system emulator";
        cores = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [];
          example = [ "genesis-plus-gx" "snes9x" "beetle-psx-hw" ];
          description = ''
            List of libretro core names to include. These correspond to attribute names in pkgs.libretro,
            such as "genesis-plus-gx", "snes9x", or "beetle-psx-hw".
          '';
        };
      };
    };
  };
  config = lib.mkMerge [
    (lib.mkIf cfg.steam.enable {
      nixpkgs.overlays = [
        (final: prev: {
          steam = prev.steam.override {
            extraArgs = "-cef-disable-gpu-compositing";
          };
        })   
      ];
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        gamescopeSession.enable = true;
        protontricks.enable = true;
        extraPackages = with pkgs; [ hidapi ];
      };
      programs.gamescope = {
        enable = true;
        capSysNice = true;
      };
      hardware.steam-hardware.enable = true;
    })
    (lib.mkIf cfg.retroarch.enable {
      environment.systemPackages = let
        retro = pkgs.retroarch.withCores (cores: map (coreName: cores.${coreName}) cfg.retroarch.cores);
      in [ retro ];
    })
    (lib.mkIf cfg.prismlauncher.enable {
      environment.systemPackages = [ pkgs.prismlauncher ];
    })
  ];
}
