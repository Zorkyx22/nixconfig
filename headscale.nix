{ pkgs, config, libs, ... }:
let
  domain = "nichaudland.ddns.net";
  port = 8080;
in {
  services.headscale = {
    enable = true;
    address = "0.0.0.0";
    port = port;
    user = "headman";
    settings = {
      server_url = "https://headscale.${domain}:${toString port}";
      dns_config = {
        base_domain = domain;
        magic_dns = true;
        domains = ["headscale.${domain}"];
        nameservers = [
          "1.1.1.1"
          "9.9.9.9"
        ];
      };
      ip_prefixes = [
        "100.64.0.0/10"
      ];
      logtail.enabled = false;
    };
  };

  services.caddy = {
    enable = true;
    virtualHosts."headscale.${domain}".extraConfig = 'reverse_proxy * 127.0.0.1:${toString port}';
    };
}
