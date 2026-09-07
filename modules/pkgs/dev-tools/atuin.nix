{...}: {
  dev-tools.atuin = {
    persist.home.data.directories = ["atuin"];

    homeManager = {
      programs.atuin = {
        enable = true;
      };
    };
  };
}
