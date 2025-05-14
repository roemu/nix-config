{ config, lib, ... }:
{
  home.username = lib.mkDefault "roemu";
  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}
