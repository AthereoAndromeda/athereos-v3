{
  den,
  inputs,
  lib,
  ...
}: {
  den.aspects.de.niri = {
    includes =
      [
        den.aspects.noctalia-v5
        den.aspects.desktop-utils
        den.aspects.cursors.lyra-q
      ]
      ++ (with den.aspects.desktop; [
        cliphist
        wpaperd
      ]);

    nixos = {pkgs, ...}: {
      imports = [inputs.niri.nixosModules.niri];
      nixpkgs.overlays = [inputs.niri.overlays.niri];
      environment.systemPackages = [pkgs.rofi pkgs.nirius pkgs.xwayland-satellite-unstable];

      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };
    };

    homeManager = {pkgs, ...}: {
      programs.niri = {
        package = pkgs.niri-unstable;

        settings = {
          xwayland-satellite = {
            enable = true;
            path = lib.getExe pkgs.xwayland-satellite-unstable;
          };
        };
      };

      xdg.configFile."niri" = {
        recursive = true;
        source = ./config;
      };
    };
  };
}
