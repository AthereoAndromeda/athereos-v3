{...}: {
  den.aspects.pkgs.pay-respects = {
    homeManager = {
      programs.pay-respects = {
        enable = true;

        # Seems to be broken
        # enableNushellIntegration = true;
      };
    };
  };
}
