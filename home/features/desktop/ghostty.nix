{config, inputs, lib, pkgs, ...}:
let 
	cfg = config.features.desktop.ghostty;
in {
	options.features.desktop.ghostty.enable = lib.mkEnableOption "Enable extended ghostty configuration";

	config = lib.mkIf cfg.enable {
		home.packages = lib.mkIf (pkgs.hostPlatform.system != "aarch64-darwin") [
			inputs.ghostty.packages."${pkgs.system}".default
		];
		home.file.".config/ghostty/config".text = ''
			background-opacity = 0.9
			background-blur = true
			background = #1e1e2e
			macos-titlebar-style = hidden
			keybind = ctrl+shift+v=paste_from_clipboard
		'';
	};
}
