{ config, pkgs, ... }:

let
  # Create a simple wrapper script that ties their lifetimes together
  vesktopWithRPC = pkgs.writeShellScriptBin "vesktop-with-rpc" ''
    #!/usr/bin/env bash
    set -euo pipefail
    # Start Jellyfin RPC in the background and remember its PID
    ${pkgs.jellyfin-rpc}/bin/jellyfin-rpc &
    pid=$!

    # When Vesktop exits, kill Jellyfin RPC
    trap "kill $pid" EXIT

    # Launch Vesktop
    exec ${pkgs.vesktop}/bin/vesktop
  '';
in
{
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
