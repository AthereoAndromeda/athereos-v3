{...}: {
  den.aspects.pkgs.yazi = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.yazi];
    };

    homeManager = {...}: {
      programs.yazi = {
        enable = true;
        enableBashIntegration = true;
        enableNushellIntegration = true;
        shellWrapperName = "y";
      };
    };
  };
}
