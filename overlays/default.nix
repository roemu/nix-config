{
  inputs,
  ...
}: {
  additions = final: _prev: import ../pkgs {pkgs = final;};

  modifications = final: prev: {
    arc-browser = prev.arc-browser.overrideAttrs (old: rec {
      version = "1.106.0-66192";
      src = prev.fetchurl {
        url = "https://releases.arc.net/release/Arc-${version}.dmg";
        hash = "sha256-AlM0wJ/2okrxw2ZpMPodlSVQaMMkBPf5iIN4bnMTaME=";
      };
      meta.knownVulerabilities = [];
    });
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
