{
  inputs,
  ...
}: {
  additions = final: _prev: import ../pkgs {pkgs = final;};

  modifications = final: prev: {
    arc-browser = prev.arc-browser.overrideAttrs (old: rec {
      version = "1.110.0-67696";
      src = prev.fetchurl {
        url = "https://releases.arc.net/release/Arc-${version}.dmg";
        hash = "sha256-Ce80v/eIcoGX3KTPV/0bKHnv3PqsvUfLE1o+kpZ/B4w=";
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
