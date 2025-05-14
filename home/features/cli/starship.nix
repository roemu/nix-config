{config, lib, ...}:
let 
	cfg = config.features.cli.starship;
in {
	options.features.cli.starship.enable = lib.mkEnableOption "Enable extended starship configuration";

	config = lib.mkIf cfg.enable {
		programs.starship = {
			enable = true;
			enableZshIntegration = true;
			settings = {
				add_newline = false;
				format = "$directory$nix_shell$git_branch$character";
				right_format = "$all";
			};
		};
	};
}
