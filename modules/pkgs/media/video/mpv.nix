{...}: {
  den.aspects.pkgs.mpv = {
    homeManager = {
      programs.mpv.enable = true;

      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "video/*" = "mpv.desktop";
        };
      };
    };
  };
}
