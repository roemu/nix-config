{
  lib,
  stdenvNoCC,
  fetchurl,
  undmg,
  ...
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "arc-browser";
  version = "1.97.1-63934";

  src = fetchurl {
    url = "https://releases.arc.net/release/Arc-${finalAttrs.version}.dmg";
    hash = "sha256-Ig1oOCuolyyBI4rtP6QXCcA6CbU89anNsHLCy5Gp+Zg=";
  };

  nativeBuildInputs = [undmg];

  sourceRoot = "Arc.app";

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications/Arc.app"
    cp -R . "$out/Applications/Arc.app"

    runHook postInstall
  '';

  dontFixup = true;

  meta = {
    description = "Arc from The Browser Company";
    homepage = "https://arc.net/";
    maintainers = with lib.maintainers; [donteatoreo];
    platforms = lib.platforms.all;
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
  };
})
