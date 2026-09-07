{...}: {
  dev-tools.delta = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.delta];
    };

    homeManager = {
      # Better diff view
      programs.delta = {
        enable = true;
        enableGitIntegration = true;
        enableJujutsuIntegration = true;
      };
    };
  };
}
