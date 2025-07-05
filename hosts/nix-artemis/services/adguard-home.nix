{...}: {
  services.adguardhome = {
    enable = true;
    openFirewall = true;
    settings = {
      http = {
        address = "0.0.0.0:3000";
      };
    };
  };
  networking.firewall.allowedTCPPorts = [3000];
  networking.firewall.allowedUDPPorts = [53];

  services.traefik.dynamicConfigOptions.http = {
    services.adguardhome.loadBalancer.servers = [
      {
        url = "http://100.64.0.1:3000/";
      }
    ];

    routers.adguardhome = {
      rule = "Host(`adguard.romansuter.ch`)";
      tls = {
        certResolver = "hetzner";
      };
      service = "adguardhome";
      entrypoints = "websecure";
    };
  };
}
