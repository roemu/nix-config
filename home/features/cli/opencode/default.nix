{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.features.cli.opencode;
in {
  options.features.cli.opencode = {
    enable = lib.mkEnableOption "Enable extended opencode configuration";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.codebase-memory-mcp
    ];
    programs.opencode = {
      enable = true;
      settings = {
        share = "disabled";
        enabled_providers = [
          "github-copilot" 
        ];
        small_model = "github-copilot/gpt-5.4-mini";
        mcp = {
          codebase-memory-mcp = {
            type = "local";
            enabled = true;
            command = ["codebase-memory-mcp"];
          };
        };
      };
    };
    home.file.".config/opencode/skills/codebase-memory-mcp/SKILL.md".source = ./skills/codebase-memory-mcp.md;
    home.file.".config/opencode/skills/caveman/SKILL.md".source = ./skills/caveman.md;
    home.file.".config/opencode/skills/caveman-review/SKILL.md".source = ./skills/caveman-review.md;
  };
}
