{
  inputs,
  ...
}: {
  additions = final: _prev: import ../pkgs {pkgs = final;};

  modifications = final: prev: {
    arc-browser = prev.arc-browser.overrideAttrs (old: rec {
      version = "1.108.0-66882";
      src = prev.fetchurl {
        url = "https://releases.arc.net/release/Arc-${version}.dmg";
        hash = "sha256-L6GZv9COYgjzoMeU36nXVvyWCYUkXxW35lodeylZ2gE=";
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
