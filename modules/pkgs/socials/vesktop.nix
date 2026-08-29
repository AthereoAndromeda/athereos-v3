{...}: {
  den.aspects.pkgs.vesktop = {
    homeManager = {
      programs.vesktop.enable = true;
    };

    persist.home.config.directories = ["vesktop"];
  };
}
