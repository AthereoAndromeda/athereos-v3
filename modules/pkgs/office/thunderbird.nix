{...}: {
  den.aspects.pkgs.thunderbird = {
    homeManager = {
      programs.thunderbird = {
        enable = true;
      };

      xdg.mimeApps.defaultApplications = {
        "x-scheme-handler/mailto" = "thunderbird.desktop";
        "x-scheme-handler/feed" = "thunderbird.desktop";
        "x-scheme-handler/news" = "thunderbird.desktop";
        "x-scheme-handler/net.thunderbird" = "thunderbird.desktop";
        "application/rss+xml" = "thunderbird.desktop";
        "application/atom+xml" = "thunderbird.desktop";
        "application/rdf+xml" = "thunderbird.desktop";
        "application/x-extension-rss" = "thunderbird.desktop";
        "application/x-xpinstall" = "thunderbird.desktop";
      };
    };

    persist.home.directories = [
      ".thunderbird"
    ];
  };
}
