{
  inputs,
  lib,
  ...
}: {
  den.aspects.xdg-utils = let
    common-config = {
      default = ["gtk"];

      # Use the 'wlr' portal for screen sharing/specific wayland tasks
      "org.freedesktop.impl.portal.Screenshot" = ["wlr"];
      "org.freedesktop.impl.portal.ScreenCast" = ["wlr"];
      "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
    };

    yazi-explorer = pkgs:
      pkgs.stdenvNoCC.mkDerivation {
        name = "explorer";
        dontUnpack = true;

        desktopItems = [
          (pkgs.makeDesktopItem {
            name = "yazi-explorer";
            desktopName = "Yazi Explorer";
            exec = "${lib.getExe pkgs.wezterm} -e ${lib.getExe pkgs.yazi}";
            categories = [];
          })
        ];

        nativeBuildInputs = [
          pkgs.copyDesktopItems
        ];
      };
  in {
    nixos = {pkgs, ...}: {
      imports = [inputs.xdg-termfilepickers.nixosModules.default];
      environment.systemPackages = [(yazi-explorer pkgs)];

      # services.xdg-desktop-portal-termfilepickers = let
      #   termfilepickers = inputs.xdg-termfilepickers.packages.${pkgs.system}.default;
      # in {
      #   enable = true;
      #   package = termfilepickers;
      #   desktopEnvironments = ["common" "niri"];
      #   config = {
      #     terminal_command = [(lib.getExe pkgs.wezterm)];
      #   };
      # };

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

      xdg.mime.defaultApplications = {
        "inode/directory" = "yazi-explorer.desktop";
        "inode/mount-point" = "yazi-explorer.desktop";
      };
    };

    homeManager = {pkgs, ...}: {
      home.packages = [(yazi-explorer pkgs)];
      xdg.mimeApps.defaultApplications = {
        "inode/directory" = "yazi-explorer.desktop";
        "inode/mount-point" = "yazi-explorer.desktop";
      };

      xdg = {
        enable = true;

        # portal = {
        #   enable = true;
        #   xdgOpenUsePortal = true;
        #   extraPortals = with pkgs; [
        #     xdg-desktop-portal-gtk
        #     xdg-desktop-portal-wlr
        #     # xdg-desktop-portal-termfilechooser
        #   ];

        #   config = {
        #     common = common-config;
        #     niri = common-config;
        #   };
        # };

        userDirs = {
          enable = true;
          createDirectories = true;
        };
      };
    };

    persist.home.directories = [
      "Documents"
      "Downloads"
      "Music"
      "Pictures"
      "Templates"
      "Videos"
    ];
  };
}
