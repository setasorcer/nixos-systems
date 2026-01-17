# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../modules/core
      inputs.nixos-hardware.nixosModules.framework-16-7040-amd
    ];

  fileSystems."/mnt/503deb8a-29bb-4295-bec4-ae7875d26688" = {
    device = "/dev/disk/by-uuid/503deb8a-29bb-4295-bec4-ae7875d26688";
    fsType = "ext4";
    options = [
      "nofail"
    ];
  };
 
  # Power saving
  #networking.networkmanager.wifi.powersave = true;
  services.udev.extraRules = ''
  SUBSYSTEM=="power_supply",ENV{POWER_SUPPLY_ONLINE}=="0",RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver"
  SUBSYSTEM=="power_supply",ENV{POWER_SUPPLY_ONLINE}=="1",RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance"
  '';

  # Framework-specific
  services.fwupd.enable = true;

  # Laptop optimizations: battery modules, disable hyprland decorations
  desktop = {
    virtualisation.enable = true;
    games = {
      steam.enable = true;
      aagl.enable = true;
      retroarch = {
        enable = true;
        cores = [
          "beetle-psx-hw"
          "dolphin"
          "pcsx2"
          "np2kai"
          "flycast"
          "mupen64plus"
        ];
      };
    };
  };
  environment.systemPackages = with pkgs; [
    anki-bin
    prismlauncher
    nexusmods-app-unfree
    obs-studio
    kdePackages.kdenlive
  ];
}
