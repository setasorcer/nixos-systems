{ pkgs, ... }:

{
  # Bootloader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.systemd.enable = true;
    loader = {
      timeout = 0;
      systemd-boot.enable = true;
      systemd-boot.consoleMode = "max";
      efi.canTouchEfiVariables = true;
    };
    plymouth = {
      enable = true;
      theme = "bgrt";
    #  themePackages = with pkgs; [
    #    (adi1090x-plymouth-themes.override {
    #      selected_themes = [ "rings" ];
    #    })
    #  ];
    };
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };
  # Don't wait for network on startup
  systemd = {
    targets.network-online.wantedBy = pkgs.lib.mkForce []; # Normally ["multi-user.target"]
    services.NetworkManager-wait-online.wantedBy = pkgs.lib.mkForce []; # Normally ["network-online.target"]
  };
  swapDevices = [{
      device = "/var/lib/swapfile";
      size = 24 * 1024;
  }];
}
