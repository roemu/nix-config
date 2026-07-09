{
  inputs,
  ...
}: {
  additions = final: prev: 
  (import ../pkgs {pkgs = final;})
  // {zen-browser = inputs.zen-browser.packages."${final.stdenv.hostPlatform.system}".twilight;};

  modifications = final: prev: {
    # podman = prev.podman.overrideAttrs (old: rec {
    #   version = "5.8.3";
    #   src = prev.fetchFromGitHub {
    #     owner = "containers";
    #     repo = "podman";
    #     tag = "v${version}";
    #     hash = "sha256-MS5eaGTcCAtEvoQUhGlX8UfoOqNOv0VAoeFxfAvB3Zs=";
    #   };
    #   meta.allowedPlatforms = prev.meta.allowedPlatforms ++ ["aarch64-darwin"];
    # });
    # arc-browser = prev.arc-browser.overrideAttrs (old: rec {
    #   version = "1.112.0-68314";
    #   src = prev.fetchurl {
    #     url = "https://releases.arc.net/release/Arc-${version}.dmg";
    #     hash = "sha256-tB+JrUtWnz8Qj1UIkPuuPTB2kFWlXK9FqQzWp5HQ4ZI=";
    #   };
    #   meta.knownVulerabilities = [];
    # });
    # vacuum-go = prev.vacuum-go.overrideAttrs (old: rec {
    #   version = "0.23.2";
    #   src = prev.fetchFromGitHub {
    #     owner = "daveshanley";
    #     repo = "vacuum";
    #     tag = "v${version}";
    #     hash = "sha256-zQ9NzNPWJC431AF1wlrRAZRhUTMdKJO6qWa4x9jpFoE=";
    #   };
    #   vendorHash = "sha256-kpW1i6LJUFMJArSHYMI4taTfAcfDH+E39GOBOKZFu+c=";
    # });
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    # prettier = prev.prettier.override {
    #   plugins = [
    #     final.prettier-plugin-java
    #   ];
    # }
  };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
