{
  lib,
  stdenvNoCC,
  fetchurl,
  undmg,
  ...
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "arc-browser";
  version = "1.99.0-64212";

  src = fetchurl {
    url = "https://releases.arc.net/release/Arc-${finalAttrs.version}.dmg";
    hash = "sha256-e0OT/ArqPbGi2DnQbxJHNnHsiuMLEBLF9BM48fo/r9M=";
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
