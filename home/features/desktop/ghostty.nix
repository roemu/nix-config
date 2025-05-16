{config, inputs, lib, pkgs, ...}:
let 
	cfg = config.features.desktop.ghostty;
in {
	options.features.desktop.ghostty.enable = lib.mkEnableOption "Enable extended ghostty configuration";

	config = lib.mkIf cfg.enable {
		home.packages = [
			inputs.ghostty.packages."${pkgs.system}".default
		];
		home.file.".config/ghostty/config".text = ''
			background-opacity = 0.9
			background-blur = true
			keybind = ctrl+v=paste_from_clipboard
		'';
	};
}
