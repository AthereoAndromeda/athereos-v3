{...}: {
  den.aspects.pkgs.carapace = {
    homeManager = {
      programs.carapace = {
        enable = true;
        enableBashIntegration = true;
        enableNushellIntegration = true;
      };
    };
  };
}
