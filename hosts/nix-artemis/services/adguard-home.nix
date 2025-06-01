{...}: {
  services.adguardhome = {
    enable = true;
    openFirewall = true;
  };
  networking.firewall.allowedTCPPorts = [80 53];
  networking.firewall.allowedUDPPorts = [53];
}
