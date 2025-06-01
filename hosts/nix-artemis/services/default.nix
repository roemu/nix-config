{
  imports = [./adguard-home.nix];
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
