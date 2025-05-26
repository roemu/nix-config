{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.darwinModules.home-manager
  ];

  home-manager.backupFileExtension = ".backup";
  system.primaryUser = "romansuter";
  nixpkgs.hostPlatform = "aarch64-darwin";

  security.pam.services.sudo_local.touchIdAuth = true;
  networking.hostName = "nix-hephaestus";

  system = {
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
    stateVersion = 5;
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
    defaults = {
      finder.AppleShowAllExtensions = true;
      finder.AppleShowAllFiles = true;
      finder.FXPreferredViewStyle = "clmv";
      dock = {
        persistent-apps = [
          "${pkgs.wezterm}/Applications/WezTerm.app"
          "${pkgs.callPackage ./arc-browser.nix {}}/Applications/Arc.app"
          "/Applications/Microsoft Teams.app"
          "/Applications/Microsoft Outlook.app"
        ];
        show-recents = false;
        autohide = true;
      };
      screencapture.location = "/tmp";
      NSGlobalDomain._HIHideMenuBar = true;
      NSGlobalDomain.AppleShowAllFiles = true;
    };
  };

  environment.systemPackages = with pkgs; [
    git
    neovim
	(pkgs.callPackage ./arc-browser.nix {})
  ];
}
