{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.features.cli.neovim;
in {
  options.features.cli.neovim.enable = lib.mkEnableOption "Enable extended neovim configuration";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.gnumake
      pkgs.gcc
      pkgs.unzip
      pkgs.cargo
      pkgs.angular-language-server
      pkgs.typescript-language-server
      pkgs.typescript
      pkgs.lua-language-server
      pkgs.nil
      pkgs.helm-ls
      pkgs.yaml-language-server
      pkgs.alejandra
      pkgs.gopls
      pkgs.bash-language-server
      pkgs.emmet-ls
      pkgs.openscad-lsp
      pkgs.libclang
      pkgs.nodejs_24
      pkgs.maven
      pkgs.nodePackages.prettier
      pkgs.websocat
      pkgs.grpcurl
    ];

    programs.java = {
      enable = true;
      package = pkgs.jdk21_headless;
    };

    programs.zsh.sessionVariables = {
      JAVA_HOME = "${pkgs.jdk21_headless}";
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
    };

    home.file = {
      ".config/nvim" = {
        source = ./nvim;
        recursive = true;
      };
    };
  };
}
