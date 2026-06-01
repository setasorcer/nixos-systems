# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../modules/core
      inputs.nixos-hardware.nixosModules.framework-12-13th-gen-intel
    ];

  services.power-profiles-daemon.enable = true; # Enable becasue nixos-hardware doesn't by default, also needed to control power usage presets

  desktop = {
    enable = true;
    niri = {
      enable = true;
      iio.enable = true;
    };
    greeter.dms.enable = true;
    games = {
      steam.enable = true;
      retroarch = {
        enable = true;
        cores = [
          "dolphin"
          "pcsx2"
          "np2kai"
          "flycast"
        ];
      };
    };
    virtualisation.waydroid.enable = true;
  };

  environment.systemPackages = with pkgs; [
    krita
    ruffle
  ];
}
