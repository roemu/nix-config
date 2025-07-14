{config, ...}: {
  services.traefik = {
    enable = true;

    staticConfigOptions = {
      api = {};
      log = {level = "WARN";};
      entryPoints = {
        web = {
          address = ":80";
          http.redirections.entryPoint = {
            to = "websecure";
            scheme = "https";
          };
        };
        websecure = {
          address = ":443";
        };
      };

      certificatesResolvers = {
        hetzner = {
          acme = {
            email = "20roman.suter02+hetzner@gmail.com";
            storage = "/var/lib/traefik/acme.json";
            caserver = "https://acme-v02.api.letsencrypt.org/directory";
            dnsChallenge = {
              provider = "hetzner";
              resolvers = ["1.1.1.1:53" "8.8.8.8:53"];
              propagation = {
                delayBeforeChecks = 60;
                disableChecks = true;
              };
            };
          };
        };
      };
    };
    dynamicConfigOptions = {
      http = {
        middlewares = {
          tailscale-auth = {
            ipWhiteList = {
              sourceRange = [
                "100.64.0.0/10"
              ];
            };
          };
          auth = {
            basicAuth = {
              users = ["roemu:$apr1$suVaGN9e$nWfmWrUP4NIXkQc9hegHE0"];
            };
          };
          domain-redirect = {
            redirectRegex = {
              regex = "^https://romansuter\\.ch(.*)";
              replacement = "https://info.romansuter.ch$1";
              permanent = true;
            };
          };
        };

        routers = {
          api = {
            rule = "Host(`traefik.romansuter.ch`)";
            service = "api@internal";
            middlewares = ["auth" "tailscale-auth"];
            entrypoints = ["websecure"];
            tls = {
              certResolver = "hetzner";
            };
          };
        };
      };
    };
  };

  systemd.services.traefik.serviceConfig = {
    EnvironmentFile = ["${config.age.secrets.hetzner-tls.path}"];
  };

  networking.firewall.allowedTCPPorts = [443];
}
