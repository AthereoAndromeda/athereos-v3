{...}: {
  den.aspects.pkgs.snapshot = {
    homeManager = {
      pkgs,
      config,
      ...
    }: {
      home.packages = [pkgs.snapshot];

      assertions = [
        {
          assertion = config.xdg.userDirs.enable;
          message = "Snapshot will fail to capture if $XDG_CONFIG_DIRS/user-dirs.dirs does not exist";
        }
      ];
    };
  };
}
