{
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./home.nix
    ../common
    ../features/cli
    ../features/desktop
    inputs.catppuccin.homeModules.catppuccin
  ];

  home.packages = [
    pkgs.bruno
    pkgs.bruno-cli
	pkgs.sops
	pkgs.gnupg
  ];

  catppuccin.enable = true;
  features = {
    cli = {
      zsh.enable = true;
      zsh.enableSudoAlias = false;
      neovim.enable = true;
      neofetch.enable = true;
      tmux.enable = true;
      starship.enable = true;
      tms.enable = true;
    };
    desktop = {
      wezterm.enable = true;
    };
  };

  programs.starship.settings.right_format = lib.mkForce ""; # Due to https://github.com/starship/starship/issues/6524

  programs.zsh.sessionVariables = {
    STAGE = "local";
    APIM_STAGE = "dev";
    MAC_M1 = "";
  };
}
