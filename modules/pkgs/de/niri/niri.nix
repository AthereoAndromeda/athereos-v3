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
      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      };

      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };
    };

    homeManager = {
      pkgs,
      config,
      ...
    }: {
      services.cliphist.enable = true;

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

      xdg.configFile."niri/cursor.kdl".text = ''
        cursor {
          xcursor-theme "${config.home.pointerCursor.name}"
          xcursor-size ${lib.toString config.home.pointerCursor.size}
        }
      '';

      # TODO
      # xdg.configFile."niri/env.kdl".text = ''
      #   cursor {
      #     xcursor-theme ${config.pointerCursor.name}
      #     xcursor-size ${config.pointerCursor.size}
      #   }
      # '';
    };
  };
}
