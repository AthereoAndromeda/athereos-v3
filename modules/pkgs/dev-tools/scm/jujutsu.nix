{...}: {
  dev-tools.jujutsu = {
    homeManager = {config, ...}: {
      programs.jujutsu = {
        enable = true;
        settings = {
          user.name = config.gitName;
          user.email = config.gitEmail;

          ui.default-command = "log";
          ui.merge-editor = ":builtin";
        };
      };

      programs.jjui = {
        enable = true;
      };
    };
  };
}
