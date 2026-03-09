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
      fastfetch.enable = true;
      starship.enable = true;
    };
  };
}
