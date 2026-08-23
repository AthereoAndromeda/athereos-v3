{den, ...}: {
  den.aspects.pkgs.shells = {
    includes = [den.aspects.pkgs.shells.nushell];

    homeManager = {...}: {
      programs.bash.enable = true;
      home.shell.enableBashIntegration = true;
      home.shell.enableNushellIntegration = true;
      home.shellAliases."nushell" = "nu";
    };
  };
}
