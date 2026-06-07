{den, ...}: {
  den.aspects.pkgs.shells = {
    includes = [den.aspects.pkgs.nushell];

    homeManager = {...}: {
      home.shellAliases = {
        j = "just";
        ff = "fastfetch";
        zj = "zellij";
      };
    };
  };
}
