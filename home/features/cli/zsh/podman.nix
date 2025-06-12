{pkgs, ...}: {
  home.packages = [pkgs.podman];
  programs.zsh.shellAliases = {
    docker = "podman";
  };
}
