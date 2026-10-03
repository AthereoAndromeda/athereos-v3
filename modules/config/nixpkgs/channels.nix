{
  den,
  inputs,
  ...
}: {
  den.aspects.nixpkgs-extend.os.nixpkgs.overlays = [
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
  ];

  den.schema.host.includes = [den.aspects.nixpkgs-extend];
}
