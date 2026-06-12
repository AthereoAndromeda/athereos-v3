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
      environment.systemPackages = [pkgs.rofi];

      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };
    };

    homeManager = {pkgs, ...}: {
      # imports = [inputs.niri.homeModules.niri]; Already automatically imported by nixos

      programs.niri = {
        # enable = lib.mkForce true;
        # package = lib.mkForce pkgs.niri-unstable;

        settings = {
          xwayland-satellite = {
            enable = true;
            path = lib.getExe pkgs.xwayland-satellite-unstable;
          };
        };
      };

      programs.fuzzel.enable = true;

      xdg.configFile."niri" = {
        recursive = true;
        source = ./config;
      };
    };
  };
}
