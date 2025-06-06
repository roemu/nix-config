let
  roemu = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOIcrTOdoPmASCfBPjt+qm/iGQ6ASExs1YtOAtKIMJty";
  romansuter = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICKnGNGP2GQeA1FCp7u3OccD8u6hQXFqJZW9rd0GJcZe";
  users = [roemu romansuter];
in {
  "secrets/password.age".publicKeys = users;
}
