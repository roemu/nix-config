{pkgs, ...}: {
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
    userName = "roemu";
    userEmail = "20roman.suter02@gmail.com";
    aliases = {
      log = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    };
    extraConfig = {
      init = {
        defaultBranch = "master";
      };
    };
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
