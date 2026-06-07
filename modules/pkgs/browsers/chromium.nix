{...}: {
  den.aspects.pkgs.chromium = {
    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.chromium];
    };
  };
}
