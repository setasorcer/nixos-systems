{ inputs, ... }:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    ./settings.nix
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = false;
    systemd.restartIfChanged = true;

    enableSystemMonitoring = false;
    enableDynamicTheming = false;
    enableCalendarEvents = false;
  };

}
