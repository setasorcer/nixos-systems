{ config, lib, pkgs, username, ... }:

let
  program = "sunsetr";
  cfg = config.programs.${program};
in {
  options.programs.${program} = {
    enable = lib.mkEnableOption "Enable ${program}";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.${program};
      defaultText = "pkgs.${program}";
      description = "The ${program} package to use.";
    };

    /*extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = ''
        Additional configuration to append to the ${program} config file.
      '';
    };*/
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    systemd.user.services.sunsetr = {
      description = "Sunsetr light filter automation";
      after = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${cfg.package}/bin/${program} -c /home/${username}/.config/sunsetr";
        Restart = "on-failure";
      };
    };
  };
}
