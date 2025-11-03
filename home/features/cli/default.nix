{pkgs, lib, ...}: {
  imports = [
    ./zsh
    ./neofetch.nix
    ./neovim.nix
    ./starship.nix
    ./tmux.nix
    ./tms.nix
    ./ssh.nix
  ];

  programs.man.enable = true;

  programs.fzf = {
    enable = true;
    enableZshIntegration = false;
  };

  programs.git = {
    enable = true;
    settings = {
      alias = {
        log = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };
      user.name = "roemu";
      user.email = "20roman.suter02@gmail.com";
      gpg.ssh.allowedSignersFile = "~/.config/git/allowed_signers";
      pull.rebase = true;
      init = {
        defaultBranch = "master";
      };
    };
    signing.format = "ssh";
    signing.signByDefault = true;
  };

  home.file = {
    ".config/git/allowed_signers".text = lib.concatStringsSep "\n" [
      ("20roman.suter02@gmail.com " + (import ../../../secrets.nix).roemu)
      ("roman.suter2@sbb.ch " + (import ../../../secrets.nix).romansuter)
    ];
  };
  home.packages = with pkgs; [
    jq
    zip
    coreutils
    less
    wget
    go
  ];
}
