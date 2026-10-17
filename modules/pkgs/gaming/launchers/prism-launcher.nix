{...}: {
  gaming.prism = {
    homeManager = {
      pkgs,
      inputs',
      ...
    }: let
      prismlauncher-cracked-fixed = inputs'.prism-launcher.packages.default.override {
        prismlauncher-unwrapped =
          (inputs'.prism-launcher.packages.prismlauncher-unwrapped.override {
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

    persist.home.data.directories = ["PrismLauncher"];
  };
}
