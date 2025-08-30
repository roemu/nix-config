{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.features.cli.tmux;
in {
  options.features.cli.tmux.enable = lib.mkEnableOption "Enable extended tmux configuration";

  config = lib.mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      baseIndex = 1;
      terminal = "tmux-256color";
      historyLimit = 100000;
      shortcut = "a";
      sensibleOnTop = true;
      keyMode = "vi";
      customPaneNavigationAndResize = true;

      plugins = with pkgs; [
        tmuxPlugins.sensible
      ];

      extraConfig = ''
        set -g status-left-length 100
        set -g 	status-left ""
        set -ag status-left "#{E:@catppuccin_status_session}"
        set -g status-right "#{E:@catppuccin_status_date_time}"
        set -g status-bg default
        set-option -g status-style bg=default

        set -g default-command $SHELL
        set-option -sa terminal-overrides ",xterm-256color:Tc"

        set-window-option -g mode-keys vi
        bind -T copy-mode-vi 'v' send -X begin-selection
        bind -T copy-mode-vi 'C-v' send -X rectangle-toggle
        bind -T copy-mode-vi 'y' send -X copy-selection

        bind -n 'C-t' neww "tms"
        bind -n 'C-h' switch-client -l
        bind C-a last-window

        bind 'n' split-window -v -c "#{pane_current_path}"
        bind 'v' split-window -h -c "#{pane_current_path}"

        set -g status-position top

        set -g set-clipboard on
        set-option -g renumber-windows on
        set -g mouse on
        set -g detach-on-destroy off
        set -gw window-active-style 'bg=default'
        set -sg escape-time 5
      '';
    };
    catppuccin.tmux.extraConfig = ''
      set -g @catppuccin_window_number_position "right"
      set -g @catppuccin_window_status_style "rounded"
      set -g @catppuccin_window_text "#W"
      set -g @catppuccin_window_current_text "#W"
      set -g @catppuccin_pane_active_border_style "fill=default bg=default fg=black"
      set -g @catppuccin_pane_border_style "fill=default bg=default fg=black"
    '';
  };
}
