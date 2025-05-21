{
  pkgs,
  inputs,
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
    pkgs.go
  ];

  catppuccin.enable = true;
  features = {
    cli = {
      zsh.enable = true;
      neovim.enable = true;
      neofetch.enable = true;
      tmux.enable = true;
      starship.enable = true;
      tms.enable = true;
    };
	desktop = {
		ghostty.enable = true;
	};
  };

  programs.zsh.sessionVariables = {
    STAGE = "local";
    APIM_STAGE = "dev";
    MAC_M1 = "";
  };
}
