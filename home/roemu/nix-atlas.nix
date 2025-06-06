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
      zen-browser.enable = true;
      hyprland.enable = true;
      waybar.enable = true;
      hyprpaper.enable = true;
      wofi.enable = true;
    };
  };
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-1,3840x2160@144Hz,0x0,1.5"
    ];
  };
}
