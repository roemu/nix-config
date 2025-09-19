{
  config,
  lib,
  ...
}: let
  cfg = config.features.cli.ssh;
in {
  options.features.cli.ssh.enable = lib.mkEnableOption "Enable extended ssh configuration";

  config = lib.mkIf cfg.enable {
    programs.ssh.enable = true;
    programs.ssh.enableDefaultConfig = false; # Deprecated in the future, thus removed already
    programs.ssh.matchBlocks = {
      "nix-artemis" = {
        hostname = "100.64.0.1";
        user = "roemu";
      };
      "nix-hephaestus" = {
        hostname = "100.64.0.2";
        user = "romansuter";
      };
      "*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };
    };
  };
}
