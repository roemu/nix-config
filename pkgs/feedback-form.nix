{
  buildGoModule,
  fetchFromGitHub,
  lib,
  ...
}:
buildGoModule rec {
  pname = "feedback-form";
  version = "1.1.4";

  src = fetchFromGitHub {
    owner = "roemu";
    repo = "feedback-form";
    rev = "v${version}";
    hash = "sha256-T1LDtSjkpUQWUwX86IqYalD5OkDrchXvjbwse62BD1U=";
    # nix run nixpkgs#nix-prefetch-git -- https://github.com/roemu/feedback-form
  };

  vendorHash = "sha256-EbxLmOtSweB/81GDLtzYLH9nrMVjWp5d72Wqws926us=";
  # Only changes if dependencies change

  env.CGO_ENABLED = 1;

  meta = {
    description = "simple feedback form";
    homepage = "https://github.com/roemu/feedback-form";
    maintainers = with lib.maintainers; [
      roemu
    ];
  };
}
