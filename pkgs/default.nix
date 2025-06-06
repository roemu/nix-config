{pkgs, ...}: {
  feedback-form = pkgs.callPackage ./feedback-form.nix {};
  arc-browser-updated = pkgs.callPackage ./arc-browser.nix {};
}
