{lib, ...}: {
  den.aspects.pkgs.starship = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.jj-starship];
    };

    homeManager = {
      programs.starship = {
        enable = true;
        enableBashIntegration = true;
        enableNushellIntegration = true;
        settings = lib.fromTOML (builtins.readFile ./zerodds-theme.toml);
      };
    };
  };
}
