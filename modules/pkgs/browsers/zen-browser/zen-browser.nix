{
  inputs,
  den,
  ...
}: {
  den.aspects.pkgs.zen-browser = {
    includes = [(den.batteries.unfree ["enhancer-for-youtube"])];

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
          AutofillAddressEnabled = false;
          AutofillCreditCardEnabled = false;
          # DisableFeedbackCommands = true;
          DisableFirefoxStudies = true;
          DontCheckDefaultBrowser = true;
          NoDefaultBookmarks = true;
          OfferToSaveLogins = true;

          EnableTrackingProtection = {
            Value = true;
            Locked = false;
            Cryptomining = true;
            Fingerprinting = true;
          };
        };

        env = {
          MOZ_USE_XINPUT2 = "1";
        };

        profiles = {
          default = import ./profiles/_default.nix pkgs;
        };
      };
    };

    persist.home.config.directories = ["zen"];
  };
}
