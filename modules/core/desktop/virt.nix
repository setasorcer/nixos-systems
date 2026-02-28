{ config, lib, pkgs, ... }:

let
  cfgvirt = config.desktop.virtualisation;
in
{
  options.desktop = {
    virtualisation.enable = lib.mkEnableOption "Enable virtualisation through QEMU and virt-manager";
  };

  config = lib.mkIf cfgvirt.enable {
    environment.systemPackages = with pkgs; [
      qemu
      virtio-win
      dnsmasq
      virtiofsd
    ];
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
  };
}
