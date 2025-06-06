{
  config,
  lib,
  ...
}: {
  home.username = lib.mkDefault "romansuter";
  home.homeDirectory = lib.mkDefault "/Users/${config.home.username}";

  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.sessionPath = [
    "/run/current-system/sw/bin"
    "$HOME/.nix-profile/bin"
  ];

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "work.github.com" = {
        identityFile = "~/.ssh/work_id_ed25519";
      };
      "!work.github.com, github.com" = {
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };
  programs.home-manager.enable = true;
}
