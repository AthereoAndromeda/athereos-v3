{
  inputs,
  den,
  withSystem,
  ...
}: {
  den.quirks.nixpkgs-overlays.description = "nixpkgs overlays collected from aspects";

  den.aspects.nixpkgs-overlays = {
    nixpkgs-overlays = _: [
      # this flake's own packages, as pkgs.local
      (final: _prev: {
        local = withSystem final.stdenv.hostPlatform.system ({config, ...}: config.packages);
      })

      (final: prev: {
        unstable = import inputs.nixpkgs ({
            inherit (final.stdenv.hostPlatform) system;
            inherit (final) config;
          }
          // {
            config.rewriteURL = url: url;
          });

        stable = import inputs.nixpkgs-stable ({
            inherit (final.stdenv.hostPlatform) system;
            inherit (final) config;
          }
          // {
            config.rewriteURL = url: url;
          });
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
