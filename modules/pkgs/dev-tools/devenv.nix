{...}: {
  dev-tools.devenv = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.devenv];
    };

    homeManager = {
      programs.devenv.enable = true;
      programs.devenv.enableNushellIntegration = true;
    };
  };
}
