{
  config,
  lib,
  ...
}: let
  cfg = config.features.cli.opencode;
in {
  options.features.cli.opencode = {
    enable = lib.mkEnableOption "Enable extended opencode configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.opencode = {
      enable = true;
    };
    home.file.".config/opencode/skills/caveman/SKILL.md".source = ./skills/caveman.md;
    home.file.".config/opencode/skills/caveman-review/SKILL.md".source = ./skills/caveman-review.md;
  };
}
