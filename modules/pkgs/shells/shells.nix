{den, ...}: {
  den.aspects.pkgs.shells = {
    includes = [den.aspects.pkgs.shells.nushell];

    homeManager = {...}: {
      programs.bash.enable = true;
      home.shell.enableBashIntegration = true;
      home.shellAliases = {
        j = "just";
        ff = "fastfetch";
        zj = "zellij";
      };
    };
  };
}
