{config, lib, ...}:
let 
	cfg = config.features.desktop.wezterm;
in {
	options.features.desktop.wezterm.enable = lib.mkEnableOption "Enable extended wezterm configuration";

	config = lib.mkIf cfg.enable {
		catppuccin.wezterm.enable = false;
		programs.wezterm = {
			enable = true;
			enableZshIntegration = false;
			extraConfig = ''

			local wezterm = require 'wezterm'
			local config = wezterm.config_builder()

			config.hide_tab_bar_if_only_one_tab = true
			config.color_scheme = 'Catppuccin Mocha'

			config.font = wezterm.font('JetBrains Mono')
			config.harfbuzz_features={ 'calt', 'liga', 'dlig', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08' }

			config.window_background_opacity = 0.9
			config.macos_window_background_blur = 15
			config.window_decorations = 'RESIZE'
			config.enable_tab_bar = false;

			config.keys = {
				{
					key = 'Q',
					mods = 'SHIFT|CTRL',
					action = wezterm.action.DisableDefaultAssignment,
				},
				{
					key = 'q',
					mods = 'SHIFT|CTRL',
					action = wezterm.action.DisableDefaultAssignment,
				},
				{
					key = 'h',
					mods = 'SHIFT|CTRL',
					action = wezterm.action.DisableDefaultAssignment,
				},
				{
					key = 'l',
					mods = 'SHIFT|CTRL',
					action = wezterm.action.DisableDefaultAssignment,
				},
			}

			return config
			'';
		};
	};
}
