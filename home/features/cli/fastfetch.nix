{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.features.cli.fastfetch;
in {
  options.features.cli.fastfetch.enable = lib.mkEnableOption "Enable extended fastfetch configuration";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.fastfetch
    ];
    # home.file.".config/fastfetch".source = ../../../fastfetch;
  };
}
