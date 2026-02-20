{ pkgs, config, lib, inputs, ... }:

let
  #cfgaagl = config.desktop.games.aagl;
  cfgsteam = config.desktop.games.steam;
in
{
  #imports = [ inputs.aagl.nixosModules.default ];

  options.desktop = {
    games = {
      #aagl.enable = lib.mkEnableOption "Enable installation of AAGL, used to launch an anime game";
      steam.enable = lib.mkEnableOption "Enable installation of Steam and other related utilities";
    };
  };
  config = lib.mkMerge [
    /*(lib.mkIf cfgaagl.enable {
      nix.settings = inputs.aagl.nixConfig; # Set up Cachix
      programs.anime-game-launcher.enable = true;
    })*/
    (lib.mkIf cfgsteam.enable {
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        gamescopeSession.enable = true;
        protontricks.enable = true;
      };
      programs.gamescope = {
        enable = true;
        capSysNice = true;
      };
      hardware.steam-hardware.enable = true;
    })
  ];
}
