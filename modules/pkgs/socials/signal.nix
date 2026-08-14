{...}: {
  den.aspects.pkgs.signal-desktop = {
    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.signal-desktop];
    };
  };
}
