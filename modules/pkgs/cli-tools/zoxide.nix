{...}: {
  den.aspects.pkgs.zoxide = {
    homeManager = {...}: {
      programs.zoxide = {
        enable = true;
        enableBashIntegration = true;
        enableNushellIntegration = true;
      };
    };
  };
}
