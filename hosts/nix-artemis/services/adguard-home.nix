{...}: {
  services.adguardhome = {
    enable = true;
    openFirewall = true;
    settings = {
      http = {
        address = "localhost:3000";
      };
    };
  };
  networking.firewall.allowedTCPPorts = [53 3000];
  networking.firewall.allowedUDPPorts = [53];

  # services.traefik.dynamicConfigOptions.http = {
  #   services.adguardhome.loadBalancer.servers = [
  #     {
  #       url = "http://localhost:3000/";
  #     }
  #   ];
  #
  #   routers.adguardhome = {
  #     rule = "Host(`adguard.romansuter.ch`)";
  #     tls = {
  #       certResolver = "hetzner";
  #     };
  #     service = "adguardhome";
  #     entrypoints = "websecure";
  #   };
  # };
}
