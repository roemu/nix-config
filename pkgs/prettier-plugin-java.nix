# https://github.com/NixOS/nixpkgs/blob/nixos-25.11/pkgs/by-name/do/dotenv-cli/package.nix
{
  lib,
  fetchYarnDeps,
  stdenv,
  yarnConfigHook,
  yarnBuildHook,
  fetchFromGitHub,
  npmHooks,
  nodejs,
}:
stdenv.mkDerivation (finalAttrs: rec {
  pname = "prettier-plugin-java";
  version = "2.9.2";

  src = fetchFromGitHub {
    owner = "jhipster";
    repo = "prettier-java";
    tag = "prettier-plugin-java@${finalAttrs.version}";
    sha256 = "sha256-Sdd7nE1mgz05W6FF8BSTPbuhcJCnV/rGzrySJSLAT7w=";
  };

  yarnOfflineCache = fetchYarnDeps {
    yarnLock = "${src}/yarn.lock";
    hash = "sha256-Y3QCh9Dv17eROlZB7Fd8z0io7cbgHasBbK+IgrCCWkY=";
  };

  nativeBuildInputs = [
    nodejs
    yarnConfigHook
    yarnBuildHook
    npmHooks.npmInstallHook
  ];

  meta = {
    description = "Prettier formatting for java";
    homepage = "https://github.com/jhipster/prettier-java";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [roemu];
  };
})
