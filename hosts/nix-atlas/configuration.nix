{ pkgs, inputs, config, ... }:
{
	imports = [
		./hardware-configuration.nix
		 inputs.home-manager.nixosModules.home-manager
	];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "nix-atlas";

	networking.networkmanager.enable = true;

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

	environment.systemPackages = with pkgs; [
		git
		neovim
		kdePackages.qtwayland
	];

	environment.sessionVariables = {
		NIXOS_OZONE_WL = "1";
	};

	hardware.graphics.enable = true;
	hardware.nvidia = {
		modesetting.enable = true;
		package = config.boot.kernelPackages.nvidiaPackages.stable;
		open = false;
		nvidiaSettings = false;
		powerManagement.enable = false;
		powerManagement.finegrained = false;
	};

	system.stateVersion = "24.05";
}
