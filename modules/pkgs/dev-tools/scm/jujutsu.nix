{...}: {
  dev-tools.jujutsu = {
    homeManager = {config, ...}: {
      programs.jujutsu = {
        enable = true;
        settings = {
          user.name = config.gitName or "";
          user.email = config.gitEmail or "";

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
