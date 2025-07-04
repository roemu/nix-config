{
  inputs,
  ...
}: {
  additions = final: _prev: import ../pkgs {pkgs = final;};

  modifications = final: prev: {
    arc-browser = prev.arc-browser.overrideAttrs (old: rec {
      version = "1.101.1-65021";
      src = prev.fetchurl {
        url = "https://releases.arc.net/release/Arc-${version}.dmg";
        hash = "sha256-FBgfwM60ca1NQmUtaXKiQ6Rz0XXtertXZTJH0N8WvBY=";
      };
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
