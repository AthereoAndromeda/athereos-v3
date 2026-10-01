{
  inputs,
  den,
  withSystem,
  ...
}: {
  den.quirks.nixpkgs-overlays.description = "nixpkgs overlays collected from aspects";

  den.aspects.nixpkgs-overlays = let
    common-config = final: {
      inherit (final.stdenv.hostPlatform) system;
      config = final.config // {rewriteURL = url: url;};
    };
  in {
    nixpkgs-overlays = _: [
      (final: _prev: {
        # this flake's own packages, as pkgs.local
        local = withSystem final.stdenv.hostPlatform.system ({config, ...}: config.packages);

        unstable = import inputs.nixpkgs (common-config final);
        stable = import inputs.nixpkgs-stable (common-config final);
      })

      # version bumps and patched builds of individual packages
      # (import ./overlays/modifications.nix {inherit inputs;})
    ];

    os = {
      nixpkgs-overlays,
      lib,
      ...
    }: {
      nixpkgs = {
        overlays = lib.unique nixpkgs-overlays;
      };
    };

    homeManager = {
      host,
      nixpkgs-overlays,
      lib,
      ...
    }:
      lib.mkIf (!host.sharedHomePkgs) {
        nixpkgs = {
          overlays = lib.unique nixpkgs-overlays;
        };
      };
  };

  den.default.includes = [den.aspects.nixpkgs-overlays];
}
