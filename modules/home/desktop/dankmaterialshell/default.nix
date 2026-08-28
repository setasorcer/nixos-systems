{ pkgs, inputs, ... }:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms-plugin-registry.nixosModules.default
    inputs.danksearch.homeModules.default
    ./settings.nix
    ./session.nix
    ./plugin.nix
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;
    systemd.restartIfChanged = true;

    enableSystemMonitoring = false;
    enableDynamicTheming = false;
    enableCalendarEvents = false;
  };
  programs.dsearch.enable = true;

  systemd.user.services.remove-directory = {
    Unit = { After = [ "dms.service" ]; };
    Service = {
      Type = "oneshot";
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 5";
      ExecStart = [ "${pkgs.coreutils}/bin/rmdir %h/pix/Screenshots" ];
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
