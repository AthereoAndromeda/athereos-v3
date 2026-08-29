{inputs, ...}: {
  den.aspects.pkgs.zen-browser = {
    homeManager = {pkgs, ...}: {
      imports = [inputs.zen-browser.homeModules.beta];
      programs.zen-browser = {
        enable = true;
        nativeMessagingHosts = [pkgs.firefoxpwa];
      };

      xdg.mimeApps.defaultApplications = {
        "text/html" = "zen-beta.desktop";
        "x-scheme-handler/http" = "zen-beta.desktop";
        "x-scheme-handler/https" = "zen-beta.desktop";
        "x-scheme-handler/about" = "zen-beta.desktop";
        "x-scheme-handler/unknown" = "zen-beta.desktop";
      };
    };

    persist.home.config.directories = ["zen"];
  };
}
