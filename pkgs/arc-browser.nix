{
  lib,
  stdenvNoCC,
  fetchurl,
  undmg,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "arc-browser";
  version = "1.126.0-72533";

  src = fetchurl {
    url = "https://releases.arc.net/release/Arc-${finalAttrs.version}.dmg";
    hash = "sha256-jPhX52/G+WkQDUX/PBw/wbShHdd5+lqDo8uWNcOkC9s=";
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
