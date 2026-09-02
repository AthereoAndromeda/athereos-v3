{lib, ...}: {
  den.aspects.pkgs.thunderbird = {
    homeManager = {
      programs.thunderbird = {
        enable = true;
      };

      xdg.mimeApps.defaultApplications = lib.genAttrs [
        "x-scheme-handler/mailto"
        "x-scheme-handler/feed"
        "x-scheme-handler/news"
        "x-scheme-handler/net.thunderbird"
        "application/rss+xml"
        "application/atom+xml"
        "application/rdf+xml"
        "application/x-extension-rss"
        "application/x-xpinstall"
      ] (_: "thunderbird.desktop");
    };

    persist.home.directories = [
      ".thunderbird"
    ];
  };
}
