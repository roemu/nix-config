{
  config,
  lib,
  ...
}: let
  cfg = config.features.cli.tms;
in {
  options.features.cli.tms.enable = lib.mkEnableOption "Enable extended tms configuration";

  config = lib.mkIf cfg.enable {
    home.file."bin/tms" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash

        if [[ $# -eq 1 ]]; then
        	selected=$1
        else
        	selected=$(find ~ ~/work ~/personal ~/dotfiles ~/sandbox  -mindepth 1 -maxdepth 1 -type d | fzf)
        fi

        if [[ -z $selected ]]; then
        	exit 0
        fi

        selected_name=$(basename "$selected" | tr . _)
        tmux_running=$(pgrep tmux)

        if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
        	tmux new-session -s $selected_name -c $selected
        	exit 0
        fi

        if ! tmux has-session -t=$selected_name 2> /dev/null; then
        	tmux new-session -ds $selected_name -c $selected
        fi

        tmux switch-client -t $selected_name
      '';
    };
  };
}
