{
  pkgs,
  username,
  ...
}: {
  system.activationScripts.preActivation = {
    enable = true;
    text = ''
      if [ ! -d "/var/lib/postgresql/" ]; then
      	echo "creating PostgreSQL data directory..."
      	sudo mkdir -m 750 -p /var/lib/postgresql/
      	chown -R ${username}:staff /var/lib/postgresql/
      fi
    '';
  };

  # ALTER USER postgres WITH PASSWORD 'postgres';
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_13;
    dataDir = "/var/lib/postgresql/13";
    authentication = "local all all trust";
    initdbArgs = [
      "-U postgres"
      "--auth=trust"
      "--no-locale"
      "--encoding=UTF8"
    ];
  };

  launchd.user.agents.postgresql.serviceConfig = {
    StandardErrorPath = "/tmp/postgres.error.log";
    StandardOutPath = "/tmp/postgres.log";
  };
}
