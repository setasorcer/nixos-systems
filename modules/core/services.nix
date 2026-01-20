{ pkgs, ... }:

{
  hardware.bluetooth.enable = true;
  environment.systemPackages = with pkgs; [ bluetui ];

  # Install services
  services = {
    # Required by noctalia-shell to monitor battery
    upower.enable = true;
    # USB automount
    devmon.enable = true;
    gvfs.enable = true;
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };

    # Cross xterm
    xserver.excludePackages = [ pkgs.xterm ];
    # Don't do anything when the lid is closed
    logind.settings.Login.HandleLidSwitch = "ignore";
    printing = {
      enable = true;
      drivers = with pkgs; [
        cups-filters
        cups-browsed
      ];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };

  programs = {
    # Enable fish here for autocompletion
    fish.enable = true;
    # naNO
    nano.enable = false;
    nix-ld = {
      enable = true;
      libraries = [(pkgs.runCommand "steamrun-lib" {}
  "mkdir $out; ln -s ${pkgs.steam-run.fhsenv}/usr/lib64 $out/lib")];
    };
  };

  systemd.timers."clear-cache" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };
  systemd.services."clear-cache" = {
    script = ''
      set -eu
      ${pkgs.bash}/bin/sh -c 'sync; echo 3 > /proc/sys/vm/drop_caches'
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
