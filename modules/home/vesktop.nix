{ config, pkgs, ... }:

let
  # Create a simple wrapper script that ties their lifetimes together
  vesktopWithRPC = pkgs.writeShellScriptBin "vesktop-with-rpc" ''
    #!/usr/bin/env bash
    set -euo pipefail

    # Start jellyfin-rpc in the background
    ${pkgs.jellyfin-rpc}/bin/jellyfin-rpc &
    rpc_pid=$!

    # Start vesktop (in foreground)
    ${pkgs.vesktop}/bin/vesktop

    # Once vesktop exits, kill jellyfin-rpc
    kill $rpc_pid 2>/dev/null || true
  '';
in
{
  home.packages = [ pkgs.vesktop ];
  xdg.desktopEntries.vesktop = {
    name = "Vesktop (with Jellyfin RPC)";
    genericName = "Discord Client";
    comment = "Discord client that automatically starts Jellyfin RPC";
    exec = "${vesktopWithRPC}/bin/vesktop-with-rpc";
    icon = "vesktop";
    terminal = false;
    categories = [ "Network" "InstantMessaging" ];
  };
}
