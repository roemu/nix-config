{...}: {
  services.adguardhome = {
    enable = true;
    openFirewall = true;
    settings = {
      http = {
        address = "100.64.0.1:3000";
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
      middlewares = ["auth" "tailscale-auth"];
      service = "adguardhome";
      entrypoints = "websecure";
    };
  };
}
