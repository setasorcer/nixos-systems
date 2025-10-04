# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ username, inputs, ... }:

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
  networking.networkmanager.wifi.powersave = true;

  # Framework-specific
  services.fwupd.enable = true;

  # Laptop optimizations: battery modules, disable hyprland decorations
  games = {
    steam.enabled = true;
    hoyo.enabled = true;
  };
  power.enabled = true;
  virtualization.enabled = true;

  networking.firewall.allowedTCPPorts = [ 2234 ];
}
