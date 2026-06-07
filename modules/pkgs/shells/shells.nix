{den, ...}: {
  den.aspects.pkgs.shells = {
    includes = [den.aspects.pkgs.shells.nushell];

    homeManager = {...}: {
      home.shellAliases = {
        j = "just";
        ff = "fastfetch";
        zj = "zellij";
      };
    };
  };
}
