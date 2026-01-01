{ pkgs, ... }:

let namecheap-ddns = pkgs.pkgs.writeShellScriptBin "update-ddns" ''
  for host in "@" "*"; do 
    /run/current-system/sw/bin/curl -s "https://dynamicdns.park-your-domain.com/update?host=$host&domain=setasorcer.xyz&password=b0197259fca84baab9e8949f283d8aef"
  done
'';
in
{
  systemd.services.namecheap-ddns = {
    description = "Update Namecheap dynamic DNS";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        ${namecheap-ddns}/bin/update-ddns
      '';
    };
  };

  systemd.timers.namecheap-ddns = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "1min";
      OnUnitActiveSec = "10min";
    };
  };
}

