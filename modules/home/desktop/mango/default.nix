{ config, inputs, ... }:

{
  imports = [
    inputs.mangowm.hmModules.mango
  ];
  wayland.windowManager.mango = {
    enable = true;
    systemd.enable = true;
  };
}
