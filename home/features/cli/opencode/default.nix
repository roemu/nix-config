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
      settings = {
        share = "disabled";
        enabled_providers = [
          "lmStudio"
          "github-copilot" 
        ];
        small_model = "github-copilot/gpt-5.4-mini";
        provider = {
          lmStudio = {
            npm = "@ai-sdk/openai-compatible";
            name = "LM Studio";
            options = {
              baseURL = "http://localhost:1234/v1";
            };
            models = {
              "zai-org/glm-4.7-flash" = {
                name = "GLM 4.7 Flash";
              };
              "https://lmstudio.ai/models/qwen/qwen3.6-27b" = {
                name = "Qwen3.6 27B";
              };
            };
          };
        };
      };
    };
    home.file.".config/opencode/skills/caveman/SKILL.md".source = ./skills/caveman.md;
    home.file.".config/opencode/skills/caveman-review/SKILL.md".source = ./skills/caveman-review.md;
  };
}
