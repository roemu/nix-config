{
  imports = [./aerospace.nix ./postgresql.nix];

  services.jankyborders = {
    enable = true;
    inactive_color = "0x00000000";
    active_color = "gradient(top_right=0x007f849c,bottom_left=0x006c7086)";
    width = 3.0;
  };

  services.tailscale.enable = true;
}
