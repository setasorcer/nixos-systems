{ config, lib, ... }:

let
  service = "pihole";
  service-ftl = "${service}-ftl";
  service-web = "${service}-web";
  cfg = config.server.services.${service};
  server = config.server;
in
{
  options.server.services.${service} = {
    enable = lib.mkEnableOption {
      description = "Enable ${service}";
    };
    url = lib.mkOption {
      type = lib.types.str;
      default = "${service}.${server.publicDomain}";
    };
    port.dns = lib.mkOption {
      type = lib.types.int;
      default = 53;
    };
    port.web = lib.mkOption {
      type = lib.types.int;
      default = 443;
    };
  };
  config = lib.mkIf cfg.enable {
    services.${service-ftl} = {
      enable = true;
      useDnsmasqConfig = true;

      settings = {
        dns.upstreams = [ "9.9.9.9" "1.1.1.1" ];
        ipv6 = false;
        resolver.resolveIPv6 = false;
      };

      lists = [
        {
          url = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/multi.txt";
          type = "block";
          enabled = true;
          description = "hagezi normal";
        }
      ];
    };
    services.${service-web} = {
      enable = true;
      ports = [ cfg.port.web ];
    };
    services.dnsmasq.settings = {
      address = [
        "/${server.publicDomain}/${server.localAddress}"
      ];
    };
    services.caddy.virtualHosts."${cfg.url}" = {
      extraConfig = ''
        reverse_proxy localhost:${toString cfg.port.web}
      '';
    };
    networking.firewall.allowedTCPPorts = [ cfg.port.dns ];
    networking.firewall.allowedUDPPorts = [ cfg.port.dns ];
  };
}
