{ pkgs, ... }:

{
  hardware.bluetooth.enable = true;
  environment.systemPackages = with pkgs; [ bluetui ];

  # Install services
  services = {
    # Mullvad
    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };

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
