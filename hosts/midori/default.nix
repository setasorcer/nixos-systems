# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ username, inputs, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../modules/core
      inputs.nixos-hardware.nixosModules.framework-12-13th-gen-intel
    ];

  home-manager.users."${username}" = {
      programs.niri.settings.outputs."eDP-1".scale = lib.mkForce 1;
      programs.niri.settings.outputs."eDP-2".scale = lib.mkForce 1;
  };

  services.power-profiles-daemon.enable = true;
  services.iio-niri.enable = true;
  programs.bazecor.enable = lib.mkForce false;

  environment.systemPackages = with pkgs; [ krita ];

  desktop = {
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
  };
}
