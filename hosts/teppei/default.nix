# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ username, inputs, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../modules/core
      inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
    ];

  fileSystems."/mnt/bd1f36e9-cffd-4aaa-a70d-7e15a6b4a4f6" = {
    device = "/dev/disk/by-uuid/bd1f36e9-cffd-4aaa-a70d-7e15a6b4a4f6";
    fsType = "ext4";
    options = [
      "nofail"
    ];
  };
 
  # Power saving
  networking.networkmanager.wifi.powersave = true;
  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_TRESH_BAT0 = 55;
      STOP_CHARGE_TRESH_BAT0 = 80;

      START_CHARGE_TRESH_BAT1 = 55;
      STOP_CHARGE_TRESH_BAT1 = 80;

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      #CPU_SCALING_MAX_FREQ_ON_BAT = 3200000;
    };
  };
  services.throttled.extraConfig = "
[GENERAL]
# Enable or disable the script execution
Enabled: True
# SYSFS path for checking if the system is running on AC power
Sysfs_Power_Path: /sys/class/power_supply/AC*/online
# Auto reload config on changes
Autoreload: True

## Settings to apply while connected to Battery power
[BATTERY]
# Update the registers every this many seconds
Update_Rate_s: 30
# Max package power for time window #1
PL1_Tdp_W: 29
# Time window #1 duration
PL1_Duration_s: 28
# Max package power for time window #2
PL2_Tdp_W: 44
# Time window #2 duration
PL2_Duration_S: 0.002
# Max allowed temperature before throttling
Trip_Temp_C: 85
# Set cTDP to normal=0, down=1 or up=2 (EXPERIMENTAL)
cTDP: 0
# Disable BDPROCHOT (EXPERIMENTAL)
Disable_BDPROCHOT: False

## Settings to apply while connected to AC power
[AC]
# Update the registers every this many seconds
Update_Rate_s: 5
# Max package power for time window #1
PL1_Tdp_W: 44
# Time window #1 duration
PL1_Duration_s: 28
# Max package power for time window #2
PL2_Tdp_W: 44
# Time window #2 duration
PL2_Duration_S: 0.002
# Max allowed temperature before throttling
Trip_Temp_C: 95
# Set HWP energy performance hints to 'performance' on high load (EXPERIMENTAL)
# Uncomment only if you really want to use it
# HWP_Mode: False
# Set cTDP to normal=0, down=1 or up=2 (EXPERIMENTAL)
cTDP: 0
# Disable BDPROCHOT (EXPERIMENTAL)
Disable_BDPROCHOT: False

# All voltage values are expressed in mV and *MUST* be negative (i.e. undervolt)! 
[UNDERVOLT.BATTERY]
# CPU core voltage offset (mV)
CORE: 0
# Integrated GPU voltage offset (mV)
GPU: 0
# CPU cache voltage offset (mV)
CACHE: 0
# System Agent voltage offset (mV)
UNCORE: 0
# Analog I/O voltage offset (mV)
ANALOGIO: 0

# All voltage values are expressed in mV and *MUST* be negative (i.e. undervolt)!
[UNDERVOLT.AC]
# CPU core voltage offset (mV)
CORE: -80
# Integrated GPU voltage offset (mV)
GPU: 0
# CPU cache voltage offset (mV)
CACHE: -80
# System Agent voltage offset (mV)
UNCORE: 0
# Analog I/O voltage offset (mV)
ANALOGIO: 0
  ";

  home-manager.users."${username}" = {
      programs.niri.settings.outputs."eDP-1".scale = 1;
      programs.niri.settings.outputs."eDP-2".scale = 1;
  };


  games.steam.enabled = true;
  virtualization.enabled = true;
}
