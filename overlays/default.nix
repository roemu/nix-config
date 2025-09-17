{
  inputs,
  ...
}: {
  additions = final: _prev: import ../pkgs {pkgs = final;};

  modifications = final: prev: {
    arc-browser = prev.arc-browser.overrideAttrs (old: rec {
      version = "1.112.0-68314";
      src = prev.fetchurl {
        url = "https://releases.arc.net/release/Arc-${version}.dmg";
        hash = "sha256-tB+JrUtWnz8Qj1UIkPuuPTB2kFWlXK9FqQzWp5HQ4ZI=";
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
