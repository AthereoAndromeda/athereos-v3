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

          aliases = {
            e.definition = ["edit"];
            e.doc = "Edit shorthand";

            ll.definition = ["log" "-T" "change_id.short() ++ \" \" ++ description ++ \"\\n\" "];
            ll.doc = "Extended log form";

            bk.definition = ["bookmark"];
            bk.doc = "Bookmark shorthand";
          };
        };
      };

      programs.jjui = {
        enable = true;
      };
    };
  };
}
