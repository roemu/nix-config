{
  pkgs,
  config,
  lib,
  ...
}: let
  adminUser = "roemu@";
  aclConfig = {
    # Groups definition
    groups = {
      "group:admins" = ["${adminUser}"];
    };

    acls = [
      # Allow all connections within the tailnet
      {
        action = "accept";
        src = ["*"];
        dst = ["*:*"];
      }
      # Allow admin to connect to their own services
      {
        action = "accept";
        src = ["${adminUser}"];
        dst = ["${adminUser}:*"];
      }
    ];

    # Auto-approvers section for routes
    autoApprovers = {
      routes = {
        "0.0.0.0/0" = ["${adminUser}"];
        "10.0.0.0/8" = ["${adminUser}"];
        "192.168.0.0/16" = ["${adminUser}"];
      };

      exitNode = ["${adminUser}"];
    };
  };
in {
  services.headscale = {
    enable = true;
    port = 3009;
    address = "0.0.0.0";
    settings = {
      server_url = "https://headscale.romansuter.ch";
      dns.base_domain = "roemu.loc";
      dns.override_local_dns = false;
      policy.path = pkgs.writeText "acl-policy.hujson" (builtins.toJSON aclConfig);
    };
  };
  systemd.services.headscale-ensure-admin = lib.mkIf config.services.headscale.enable {
    description = "Ensure Headscale admin user exists";
    after = ["headscale.service"];
    requires = ["headscale.service"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      User = "headscale";
      Group = "headscale";
    };

    script = ''
      # Check if user exists and create if needed
      if ! ${pkgs.headscale}/bin/headscale users list | grep -q "${adminUser}"; then
        echo "Creating headscale admin user: ${adminUser}"
        ${pkgs.headscale}/bin/headscale users create "${adminUser}"
      else
        echo "Headscale admin user ${adminUser} already exists"
      fi
    '';
  };

  networking.firewall.allowedTCPPorts = [3009];
  networking.firewall.allowedUDPPorts = [3009];

  services.traefik.dynamicConfigOptions.http = {
    services.headscale.loadBalancer.servers = [
      {
        url = "http://localhost:3009/";
      }
    ];

    routers.headscale = {
      rule = "Host(`headscale.romansuter.ch`)";
      tls = {
        certResolver = "hetzner";
      };
      service = "headscale";
      entrypoints = "websecure";
    };
  };
}
