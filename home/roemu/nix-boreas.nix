{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./home.nix
    ../common
    ../features/cli
    inputs.catppuccin.homeModules.catppuccin
  ];

  home.packages = [
    pkgs.sqlite
  ];

  features = {
    cli = {
      zsh.enable = true;
      neovim.enable = true;
      neofetch.enable = true;
      starship.enable = true;
    };
  };
}
