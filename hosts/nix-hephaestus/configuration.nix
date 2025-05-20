{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.darwinModules.home-manager
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nix-hephaestus";

  security.pam.services.sudo_local.touchIdAuth = true;

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
          "${pkgs.callPackage ../../modules/nix-darwin/arc-browser.nix {}}/Applications/Arc.app"
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
  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_CH.UTF-8";
    LC_IDENTIFICATION = "de_CH.UTF-8";
    LC_MEASUREMENT = "de_CH.UTF-8";
    LC_MONETARY = "de_CH.UTF-8";
    LC_NAME = "de_CH.UTF-8";
    LC_NUMERIC = "de_CH.UTF-8";
    LC_PAPER = "de_CH.UTF-8";
    LC_TELEPHONE = "de_CH.UTF-8";
    LC_TIME = "de_CH.UTF-8";
  };

  environment.systemPackages = with pkgs; [
    git
    neovim
	pkgs.callPackage ./arc-browser.nix {}
  ];
}
