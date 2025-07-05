{
  imports = [
    ./tailscale.nix
  ];
  services.xserver.xkb = {
    layout = "za";
    variant = "";
  };
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
    allowSFTP = true;
  };
}
