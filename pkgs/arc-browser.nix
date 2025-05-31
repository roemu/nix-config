{
  lib,
  stdenvNoCC,
  fetchurl,
  undmg,
  ...
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "arc-browser";
  version = "1.95.1-62956";

  src = fetchurl {
    url = "https://releases.arc.net/release/Arc-${finalAttrs.version}.dmg";
    hash = "sha256-JsYpuDslY2sffTM2L7Ccchs/EKvyhGE3AWiDSjFNGLw=";
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
    maintainers = with lib.maintainers; [ donteatoreo ];
	platforms = lib.platforms.all;
	badPlatforms = lib.platforms.linux;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
})
