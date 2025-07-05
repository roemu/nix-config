{
  config,
  lib,
  pkgs,
  ...
}: {
  services.tailscale = {
    enable = true;
    authKeyFile = config.age.secrets.tailscale-key.path;
    useRoutingFeatures = "client";
    extraUpFlags = [
      "--login-server=https://headscale.romansuter.ch"
    ];
  };
  services.networkd-dispatcher = lib.mkIf config.services.tailscale.enable {
    enable = true;
    rules."50-tailscale" = {
      onState = ["routable"];
      script = ''
        NETDEV=$(ip -o route get 8.8.8.8 | cut -f 5 -d " ")
        ${pkgs.ethtool}/bin/ethtool -K "$NETDEV" rx-udp-gro-forwarding on rx-gro-list off
      '';
    };
  };
}
