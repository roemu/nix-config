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
    programs.ssh.matchBlocks = {
      "nix-artemis" = {
        hostname = "100.64.0.1";
        user = "roemu";
      };
      "nix-hephaestus" = {
        hostname = "100.64.0.2";
        user = "romansuter";
      };
    };
  };
}
