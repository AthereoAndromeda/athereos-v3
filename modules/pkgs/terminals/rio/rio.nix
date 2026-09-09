{...}: {
  den.aspects.pkgs.terminals.rio = {
    nixos = {pkgs, ...}: {environment.systemPackages = [pkgs.rio];};

    homeManager = {
      programs.rio = {
        enable = true;
        settings = {
          window = {opacity = 0.8;};
        };
      };
    };
  };
}
