{ config, lib, ... }:
{
  home.username = lib.mkDefault "romansuter";
  home.homeDirectory = lib.mkDefault "/Users/${config.home.username}";

  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.sessionPath = [
  	"/run/current-system/sw/bin"
	"$HOME/.nix-profile/bin"
  ];

  programs.home-manager.enable = true;
}
