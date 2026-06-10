{
  lib,
  stdenvNoCC,
  fetchurl,
  undmg,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "arc-browser";
  version = "1.146.0-80402";

  src = fetchurl {
    url = "https://releases.arc.net/release/Arc-${finalAttrs.version}.dmg";
    hash = "sha256-ERpeIN8iRWt554lhD1k50Ye66xLjDV5wePoA6iZO4aQ=";
  };

  nativeBuildInputs = [ undmg ];

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
    license = lib.licenses.unfree;
    maintainers = with lib.maintainers; [ roemu ];
    platforms = [
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
})
