{ inputs, ... }:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms-plugin-registry.modules.default
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

}
