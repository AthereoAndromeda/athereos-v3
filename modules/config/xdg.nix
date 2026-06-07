{...}: {
  den.aspects.xdg-utils = {
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
            common = {
              default = "gtk";

              # Use the 'wlr' portal for screen sharing/specific wayland tasks
              "org.freedesktop.impl.portal.Screenshot" = ["wlr"];
              "org.freedesktop.impl.portal.ScreenCast" = ["wlr"];
              "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
            };
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
