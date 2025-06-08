{
  imports = [./adguard-home.nix ./headscale.nix ./tailscale.nix];
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
    allowSFTP = true;
  };
  networking.firewall.allowedTCPPorts = [22];
}
