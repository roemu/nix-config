{
  config,
  lib,
  ...
}: let
  cfg = config.features.cli.zsh;
in {
  options.features.cli.zsh = {
    enable = lib.mkEnableOption "Enable extended zsh configuration";
    enableSudoAlias = lib.mkOption {
      description = "Enable sudo alias for /run/wrappers/bin/sudo";
      type = lib.types.bool;
      default = true;
      example = false;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = lib.mkMerge [
        {
          ll = "ls -alh --color";
          cat = "bat --theme=\"base16-256\"";
          cd = "z";
        }
        (lib.mkIf cfg.enableSudoAlias
          {
            sudo = "/run/wrappers/bin/sudo";
          })
      ];
      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
      sessionVariables = {
        VISUAL = "nvim";
        ZDOTDIR = "$HOME";
        PATH = "$PATH:/usr/local/bin:$HOME/bin:$HOME/.cargo/bin";
        MANPATH = "$HOME/local/share/man:$MANPATH";
        LD_LIBRARY_PATH = "$HOME/local/lib:$LD_LIBRARY_PATH";
        HISTFILE = "$ZDOTDIR/.zhistory";
        XDG_CONFIG_HOME = "$HOME/.config";
        KEYTIMEOUT = 1;
      };

      initContent = ''
        bindkey -v
        bindkey ^P history-beginning-search-backward
        bindkey ^N history-beginning-search-forward
        bindkey '^?' backward-delete-char
        bindkey '^y' autosuggest-accept

        if [ -e $HOME/.secrets-zsh ]; then
        	source $HOME/.secrets-zsh
        fi

        bindkey -r '^T'

        autoload edit-command-line
        zle -N edit-command-line
        bindkey -M vicmd v edit-command-line

        export PATH=/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH
      '';
    };
  };
}
