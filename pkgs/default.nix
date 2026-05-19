{pkgs, ...}: {
  feedback-form = pkgs.callPackage ./feedback-form.nix {};
  arc-browser = pkgs.callPackage ./arc-browser.nix {};
  prettier-plugin-java = pkgs.callPackage ./prettier-plugin-java.nix {};
}
