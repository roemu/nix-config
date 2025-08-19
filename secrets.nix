let
  roemu = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOIcrTOdoPmASCfBPjt+qm/iGQ6ASExs1YtOAtKIMJty 20roman.suter02@gmail.com";
  romansuter = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICKnGNGP2GQeA1FCp7u3OccD8u6hQXFqJZW9rd0GJcZe roman.suter2@sbb.ch";
  users = [roemu romansuter];

  nix-atlas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIId5A6+nMeYdkVDPiDU2ivSPpBsFZIOfu9quyuqvJLra";
  nix-artemis = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHzoSRLWlXw3ZhmhEJlkswNysLVxDR2xHK/rOQkjJgS1";
  systems = [nix-atlas nix-artemis];
in {
  inherit roemu romansuter;
  "secrets/password.age".publicKeys = users ++ systems;
  "secrets/tailscale-key.age".publicKeys = users ++ systems;
  "secrets/hetzner-tls.age".publicKeys = users ++ systems;
}
