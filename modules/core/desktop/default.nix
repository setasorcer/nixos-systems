{ config, lib, username, pkgs, inputs, ... }:

let
  cfg = config.desktop;
in
{
  options.desktop = {
    enable = lib.mkEnableOption "Desktop applications and configuration options";
    defaultCompositor = lib.mkOption {
      description = "The wayland compositor dms-greeter will run in. Can only be of 3 options: 'niri', 'hyprland', and 'sway'";
      type = lib.types.enum [ "niri" "hyprland" "sway" ];
      default = "niri";
    };
    niri = {
      enable = lib.mkEnableOption "Enable the niri compositor";
      iio.enable = lib.mkEnableOption "Enable the niri-iio program for convertible laptops";
    };
    greeter = {
      dms.enable = lib.mkEnableOption "Enable the DankMaterialShell greeter from the DankLinux suite";
      noctalia.enable = lib.mkEnableOption "Enable the Noctalia greeter from the Noctalia suite";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      environment.variables.NIXOS_OZONE_WL = "1"; # Attempts to force wayland on discord, fixes drag-and-drop
      environment.systemPackages = with pkgs; [
        wl-clipboard
        wayland-utils
      ];
    })
    (lib.mkIf cfg.niri.enable {
      desktop.defaultCompositor = "niri";
      programs.niri = {
        enable = true;
      };
    })
    (lib.mkIf cfg.niri.iio.enable {
      services.iio-niri.enable = true;
    })
    (lib.mkIf cfg.greeter.dms.enable {
      services.displayManager.dms-greeter = {
        enable = true;
        compositor.name = cfg.defaultCompositor;
        configHome = "/home/${username}";
        package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
      };
    })
    (lib.mkIf cfg.greeter.noctalia.enable {
      services.displayManager.noctalia-greeter = {
        enable = true;
        cursorTheme = {
          name = "BreezeX-RosePineDawn-Linux";
          package = pkgs.rose-pine-cursor;
        };
      };
    })
  ];

  imports = [
    ./fonts.nix
    ./games.nix
    ./input.nix
    ./stylix.nix
    ./virt.nix
  ];
}
