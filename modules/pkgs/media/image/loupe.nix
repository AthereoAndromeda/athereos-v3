{...}: {
  den.aspects.pkgs.loupe = {
    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.loupe];

      xdg.mimeApps.defaultApplications = {
        "image/*" = "org.gnome.Loupe.desktop";
      };
    };
  };
}
