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
      default = "${server.localDomain}:${toString cfg.port.web}";
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
      address = [ "/${server.baseDomain}/${server.localDomain}" ];
    };
    networking.firewall.allowedTCPPorts = [ cfg.port.dns cfg.port.web ];
    networking.firewall.allowedUDPPorts = [ cfg.port.dns ];
  };
}
