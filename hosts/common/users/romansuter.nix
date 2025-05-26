{
  config,
  ...
}: {
  users.users.romansuter = {
    home = "/Users/romansuter";
  };
  home-manager.users.romansuter = import ../../../home/romansuter/${config.networking.hostName}.nix;
}
