{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.features.desktop.waypaper;
in {
  options.features.desktop.waypaper.enable = lib.mkEnableOption "Enable extended waypaper configuration";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.swww
      pkgs.waypaper
    ];
    home.file."wallpapers".source = ./wallpapers;
    home.file.".config/waypaper/config.ini".text = ''
      [Settings]
      language = en
      folder = ~/wallpapers
      monitors = All
      wallpaper = ~/wallpapers/dragon.jpg
      show_path_in_tooltip = True
      backend = swww
      fill = fill
      sort = name
      color = #ffffff
      subfolders = False
      all_subfolders = False
      show_hidden = False
      show_gifs_only = False
      post_command =
      number_of_columns = 3
      swww_transition_type = any
      swww_transition_step = 90
      swww_transition_angle = 0
      swww_transition_duration = 2
      swww_transition_fps = 60
      mpvpaper_sound = False
      mpvpaper_options =
      use_xdg_state = False
    '';
  };
}
