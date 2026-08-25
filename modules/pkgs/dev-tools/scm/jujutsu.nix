{...}: {
  dev-tools.jujutsu = {
    homeManager = {config, ...}: {
      programs.jujutsu = {
        enable = true;
        settings = {
          user.name = "AthereoAndromeda";
          user.email = config.gitEmail;

          ui.default-command = "log";
        };
      };

      programs.jjui = {
        enable = true;
      };
    };
  };
}
