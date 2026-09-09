{...}: {
  den.aspects.pkgs.terminals.wezterm = {
    homeManager = {...}: {
      programs.wezterm = {
        enable = true;
        extraConfig = builtins.readFile ./wezterm.lua;
      };
    };
  };
}
