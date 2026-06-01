{ config, lib, pkgs, ... }:

let
  cfg = config.desktop.virtualisation;
in
{
  options.desktop = {
    virtualisation = {
      qemu.enable = lib.mkEnableOption "Enable virtualisation through QEMU and virt-manager";
      waydroid.enable = lib.mkEnableOption "Enable Android virtualisation through Waydroid";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.qemu.enable {
      environment.systemPackages = with pkgs; [
        qemu
        virtio-win
        dnsmasq
      ];
      virtualisation.libvirtd = {
        enable = true;
        qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
      };
      programs.virt-manager.enable = true;
    })
    (lib.mkIf cfg.waydroid.enable {
      virtualisation.waydroid = {
        enable = true;
        package = pkgs.waydroid-nftables;
      };
    })
  ];
}
