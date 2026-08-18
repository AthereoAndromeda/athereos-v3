{...}: {
  den.aspects.pkgs.kew = {
    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.kew];
    };
  };
}
