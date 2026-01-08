{pkgs, ...}: {
  system.activationScripts.preActivation = {
    enable = true;
    text = ''
      if [ ! -d "/var/lib/postgresql/" ]; then
      	echo "creating PostgreSQL data directory..."
      	sudo mkdir -m 750 -p /var/lib/postgresql/
      	chown -R romansuter:staff /var/lib/postgresql/
      fi
    '';
  };

  # psql -U postgres
  # ALTER USER postgres WITH PASSWORD 'postgres';
  # CREATE DATABASE apim;
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_18;
    dataDir = "/var/lib/postgresql/18";
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
