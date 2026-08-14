{...}: {
  den.aspects.pkgs.vesktop = {
    homeManager = {...}: {
      programs.vesktop.enable = true;
    };

    persist.home.directories = [
      ".config/vesktop"
    ];
  };
}
