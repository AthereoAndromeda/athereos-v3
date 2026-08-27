{den, ...}: {
  den.schema.flake-system.includes = [
    den.aspects.pkgs.cbonsai
  ];

  den.aspects.pkgs.cbonsai = {
    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.cbonsai];
    };

    packages = {pkgs, ...}: {
      inherit (pkgs) cbonsai;
    };

    devshell.motd = ''
      Test
    '';
  };
}
