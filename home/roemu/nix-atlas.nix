{ inputs, ... }: {
	imports = [ 
		./home.nix 
		../common 
		../features/cli 
		../features/desktop
		inputs.catppuccin.homeModules.catppuccin
	]; 
	catppuccin.enable = true;
	features = {
		cli = {
			zsh.enable = true;
			neovim.enable = true;
			neofetch.enable = true;
			tmux.enable = true;
			starship.enable = true;
			tms.enable = true;
		};
		desktop = {
			ghostty.enable = true;
			zen-browser.enable = true;
			hyprland.enable = true;
			waybar.enable = true;
			waypaper.enable = true;
			wofi.enable = true;
		};
	};
}
