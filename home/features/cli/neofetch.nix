{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.features.cli.neofetch;
in {
  options.features.cli.neofetch.enable = lib.mkEnableOption "Enable extended neofetch configuration";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.neofetch
    ];
    # home.file.".config/neofetch".source = ../../../neofetch;
  };
}
