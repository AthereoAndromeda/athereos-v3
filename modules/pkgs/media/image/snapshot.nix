{...}: {
  den.aspects.pkgs.snapshot = {
    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.snapshot];
    };
  };
}
