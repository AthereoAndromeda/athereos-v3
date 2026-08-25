{...}: {
  dev-tools.jujutsu = {
    homeManager = {
      programs.jujutsu = {
        enable = true;
        settings = {
          user.name = "AthereoAndromeda";
          user.email = "athereoandromeda@gmail.com";

          ui.default-command = "log";
        };
      };

      programs.jjui = {
        enable = true;
      };
    };
  };
}
