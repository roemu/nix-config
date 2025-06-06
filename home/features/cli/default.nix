{pkgs,...}: {
	imports = [
		./zsh.nix
		./neofetch.nix
		./neovim.nix  
		./starship.nix	
		./tmux.nix    	
		./tms.nix
	];
	programs.bat = {
    		enable = true;
		config = {
			pager = "less -R";
		};
	};

	programs.man.enable = true;

	programs.fzf = {
		enable = true;
	};

	programs.git = {
		enable = true;
		userName = "roemu";
		userEmail = "20roman.suter02@gmail.com";
		aliases = {
			log = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
		};
		extraConfig = {
			init = {
				defaultBranch = "master";
			};
		};
	};

	programs.zoxide = {
		enable = true;
		enableZshIntegration = true;
	};

	home.packages = with pkgs; [
		jq
		zip
		ripgrep
		coreutils
		less
		wget
		go
	];
}
