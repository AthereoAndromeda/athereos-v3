{...}: {
  den.aspects.pkgs.direnv = {
    homeManager = {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableBashIntegration = true;
        enableNushellIntegration = true;
      };
    };
  };
}
