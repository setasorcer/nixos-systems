{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../modules/server
    ];
  
  fileSystems."/mnt/42a02f06-ecc3-4c19-b979-d92c3fe9323b" = {
    device = "/dev/disk/by-uuid/42a02f06-ecc3-4c19-b979-d92c3fe9323b";
    fsType = "ext4";
    options = [
      "nofail"
    ];
  };
  fileSystems."/mnt/zichi" = {
    device = "zichi";
    fsType = "zfs";
    options = [ "nofail" ];
  };  
}
