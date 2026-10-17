{...}: {
  gaming.zeroad = {
    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.zeroad];
    };
  };
}
