{config, lib, ...}:
let 
	cfg = config.features.desktop.hyprpaper;
in {
	options.features.desktop.hyprpaper.enable = lib.mkEnableOption "Enable extended hyprpaper configuration";

	config = lib.mkIf cfg.enable {
		services.hyprpaper.enable = true;
		services.hyprpaper.settings = {
			ipc = true;
		};
		home.file."wallpapers".source = ./wallpapers;
		home.file."bin/random-wallpaper" = {
			executable = true;
			text = ''
			#!/usr/bin/env bash

			WALLPAPER_DIR="$HOME/wallpapers/"
			CURRENT_WALL=$(hyprctl hyprpaper listloaded)

			# Get a random wallpaper that is not the current one
			WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

			# Apply the selected wallpaper
			hyprctl hyprpaper reload ,"$WALLPAPER"
			'';
		};
		wayland.windowManager.hyprland.settings = {
			exec-once = [
				"random-wallpaper"
			];
		};
	};
}
