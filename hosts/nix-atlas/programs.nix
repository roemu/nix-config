{...}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.zsh.enable = true;

  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
  };

  programs.ssh.extraConfig = ''
    Host nix-boreas
    	HostName 95.216.153.161
    	Port 2222
  '';
}
