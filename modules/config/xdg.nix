{...}: {
  den.aspects.xdg-utils = let
    common-config = {
      default = ["gtk"];

      # Use the 'wlr' portal for screen sharing/specific wayland tasks
      "org.freedesktop.impl.portal.Screenshot" = ["wlr"];
      "org.freedesktop.impl.portal.ScreenCast" = ["wlr"];
      "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
    };
  in {
    nixos = {pkgs, ...}: {
      xdg.portal = {
        enable = true;
        wlr.enable = true;

        xdgOpenUsePortal = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-wlr
          # xdg-desktop-portal-termfilechooser
        ];

        config = {
          common = common-config;
          niri = common-config;
        };
      };
    };

    homeManager = {pkgs, ...}: {
      xdg = {
        enable = true;

        portal = {
          enable = true;
          xdgOpenUsePortal = true;
          extraPortals = with pkgs; [
            xdg-desktop-portal-gtk
            xdg-desktop-portal-wlr
            # xdg-desktop-portal-termfilechooser
          ];

          config = {
            common = common-config;
            niri = common-config;
          };
        };

        userDirs = {
          enable = true;
          createDirectories = true;
        };
      };
    };
  };
}
