{
  inputs,
  lib,
  ...
}: {
  den.aspects.pkgs.zen-browser = {
    homeManager = {pkgs, ...}: {
      imports = [inputs.zen-browser.homeModules.beta];

      programs.zen-browser = {
        enable = true;
        setAsDefaultBrowser = true;
        nativeMessagingHosts = [pkgs.firefoxpwa];

        # Common browser policies configuration
        # Reference: https://mozilla.github.io/policy-templates/
        policies = {
          DisableAppUpdate = true;
          DisableTelemetry = true;
          DisablePocket = true;
        };

        env = {
          MOZ_USE_XINPUT2 = "1";
        };
      };

      xdg.mimeApps.defaultApplications = lib.genAttrs [
        "text/html"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "x-scheme-handler/about"
        "x-scheme-handler/unknown"
      ] (_: "zen-beta.desktop");
    };

    persist.home.config.directories = ["zen"];
  };
}
