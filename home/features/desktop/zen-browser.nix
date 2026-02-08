{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.features.desktop.zen-browser;
in {
  options.features.desktop.zen-browser.enable = lib.mkEnableOption "Enable extended zen-browser configuration";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.zen-browser
    ];
  };
}
