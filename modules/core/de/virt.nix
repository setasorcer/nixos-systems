{ config, lib, pkgs, ... }:

let
  cfgvirt = config.virtualization;
in
{
  options.desktop = {
    virtualization.enable = lib.mkEnableOption "Enable virtualization through QEMU and virt-manager";
  };

  config = lib.mkIf cfgvirt.enable {
    environment.systemPackages = with pkgs; [
      qemu
      virtio-win
    ];
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
  };
}
