{ config, lib, pkgs, ... }:

let
  cfg = config.desktop.games.retroarch;
in {
  options.desktop.games.retroarch = {
    enable = lib.mkEnableOption "RetroArch multi-system emulator";
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

  config = lib.mkIf cfg.enable {
    environment.systemPackages = let
      retro = pkgs.retroarch.withCores (cores: map (coreName: cores.${coreName}) cfg.cores);
    in [ retro ];
  };
}
