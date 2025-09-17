{pkgs, ...}: {
  feedback-form = pkgs.callPackage ./feedback-form.nix {};
  arc-browser = pkgs.callPackage ./arc-browser.nix {};
}
