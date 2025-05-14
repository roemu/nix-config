{ inputs, config, pkgs, ... }: {
	users.users.roemu = {
		isNormalUser = true;
		description = "roemu";
		extraGroups = [ "audio" "sudo" "networkmanager" "wheel" "docker" ];
		initialHashedPassword = "$6$m0UyQU539SJsIcio$/xB5aaLl9tGjSt3sdyzFLK.P5rOxTGIwku4IKvFptK2KfWP57GFPLbTTUxQZTPGye0ZB8ItSU6kchbo6KIHuz0";
		openssh.authorizedKeys.keys = [
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOIcrTOdoPmASCfBPjt+qm/iGQ6ASExs1YtOAtKIMJty"
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICKnGNGP2GQeA1FCp7u3OccD8u6hQXFqJZW9rd0GJcZe"
		];
		packages = [inputs.home-manager.packages.${pkgs.system}.default];
	};
	home-manager.users.roemu = import ../../../home/roemu/${config.networking.hostName}.nix;
}
