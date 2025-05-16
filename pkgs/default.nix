{ pkgs, ... }:
{
  feedback-form = pkgs.callPackage ./feedback-form.nix {};
}
