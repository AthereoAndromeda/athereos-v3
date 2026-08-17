{inputs, ...}: {
  gaming.prism = {
    homeManager = {pkgs, ...}: let
      prismlauncher-cracked-fixed = inputs.prism-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
        prismlauncher-unwrapped =
          (inputs.prism-launcher.packages.${pkgs.stdenv.hostPlatform.system}.prismlauncher-unwrapped.override {
            extra-cmake-modules = pkgs.kdePackages.extra-cmake-modules;
          }).overrideAttrs (oldAttrs: {
            nativeBuildInputs =
              (oldAttrs.nativeBuildInputs or [])
              ++ [
                pkgs.pkg-config
              ];
          });
      };
    in {
      home.packages = [prismlauncher-cracked-fixed];
    };
  };
}
