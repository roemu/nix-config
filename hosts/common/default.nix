# Common configuration for all hosts

{ lib, inputs, outputs, pkgs, ... }: {
	home-manager = {
		useUserPackages = true;
		extraSpecialArgs = {inherit inputs outputs;};
	};
	fonts.packages = [
		pkgs.nerd-fonts.jetbrains-mono
	];
	nixpkgs = {
		# You can add overlays here
		overlays = [
			# Add overlays your own flake exports (from overlays and pkgs dir):
			outputs.overlays.additions
			outputs.overlays.modifications
			outputs.overlays.stable-packages

			# You can also add overlays exported from other flakes:
			# neovim-nightly-overlay.overlays.default

			# Or define it inline, for example:
			# (final: prev: {
			#   hi = final.hello.overrideAttrs (oldAttrs: {
			#     patches = [ ./change-hello-to-hi.patch ];
			#   });
			# })
		];
		config = {
			allowUnfree = true;
		};
	};

	nix = {
		settings = {
			experimental-features = "nix-command flakes";
			trusted-users = [
				"root"
				"roemu"
				"romansuter"
			]; # Set users that are allowed to use the flake command
		};
		gc = {
			automatic = true;
			options = "--delete-older-than 30d";
		};
		optimise.automatic = true;
		registry = (lib.mapAttrs (_: flake: { inherit flake; }))
			((lib.filterAttrs (_: lib.isType "flake")) inputs);
		nixPath = [ "/etc/nix/path" ];
	};
	users.defaultUserShell = pkgs.zsh;
}
