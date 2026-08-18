{...}: {
  den.aspects.pkgs.amberol = {
    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.amberol];
    };
  };
}
