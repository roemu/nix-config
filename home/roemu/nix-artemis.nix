{inputs, ...}: {
  imports = [
    ./home.nix
    ../common
    ../features/cli
    ../features/desktop
    inputs.catppuccin.homeModules.catppuccin
  ];

  home.packages = [
  ];

  catppuccin.enable = true;
  features = {
    cli = {
      zsh.enable = true;
      neovim.enable = true;
      fastfetch.enable = true;
      tmux.enable = true;
      starship.enable = true;
      tms.enable = true;
      ssh.enable = true;
    };
  };
}
