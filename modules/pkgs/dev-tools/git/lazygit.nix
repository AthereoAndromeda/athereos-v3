{...}: {
  dev-tools.lazygit = {
    homeManager = {
      programs.lazygit = {
        enable = true;
        settings = {
          git.diffRenderers = [{command = "delta --dark --paging=never";}];
        };
      };
    };
  };
}
