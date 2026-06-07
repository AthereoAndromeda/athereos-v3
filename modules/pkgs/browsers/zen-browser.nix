{inputs, ...}: {
  den.aspects.pkgs.zen-browser = {
    homeManager = {pkgs, ...}: {
      imports = [inputs.zen-browser.homeModules.beta];
      programs.zen-browser = {
        enable = true;
        # nativeMessagingHosts = [pkgs.firefoxpwa];
      };
    };
  };
}
