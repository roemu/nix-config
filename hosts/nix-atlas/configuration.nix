{ pkgs, inputs, ... }:
{
	imports = [
		./hardware-configuration.nix
		 inputs.home-manager.nixosModules.home-manager
	];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "nix-atlas";

	networking.networkmanager.enable = true;
	services.openssh = {
		enable = true;
		settings.PermitRootLogin = "no";
		allowSFTP = true;
	};

	time.timeZone = "Europe/Zurich";
	i18n.defaultLocale = "en_US.UTF-8";
	i18n.extraLocaleSettings = {
		LC_ADDRESS = "de_CH.UTF-8";
		LC_IDENTIFICATION = "de_CH.UTF-8";
		LC_MEASUREMENT = "de_CH.UTF-8";
		LC_MONETARY = "de_CH.UTF-8";
		LC_NAME = "de_CH.UTF-8";
		LC_NUMERIC = "de_CH.UTF-8";
		LC_PAPER = "de_CH.UTF-8";
		LC_TELEPHONE = "de_CH.UTF-8";
		LC_TIME = "de_CH.UTF-8";
	};
	services.xserver.xkb = {
		layout = "za";
		variant = "";
	};

	environment.systemPackages = with pkgs; [
		git
		neovim
	];

	system.stateVersion = "24.05";
}
