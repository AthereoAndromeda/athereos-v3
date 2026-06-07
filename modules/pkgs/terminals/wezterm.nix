{...}: {
  den.aspects.pkgs.wezterm = {
    homeManager = {...}: {
      programs.wezterm = {
        enable = true;
        extraConfig = builtins.readFile ./wezterm.lua;
      };
    };
  };
}
