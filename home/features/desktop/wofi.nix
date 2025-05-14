{config, lib, pkgs, ...}:
let 
	cfg = config.features.desktop.wofi;
in {
	options.features.desktop.wofi.enable = lib.mkEnableOption "Enable extended wofi configuration";

	config = lib.mkIf cfg.enable {
		home.packages = [
			pkgs.wofi
		];
		home.file.".config/wofi/config".source = ./wofi/config;
		home.file.".config/wofi/style.css".source = ./wofi/style.css;
	};
}
