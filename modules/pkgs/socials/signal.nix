{...}: {
  den.aspects.pkgs.signal-desktop = {
    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.signal-desktop];
    };

    persist.home.config.directories = ["Signal"];
  };
}
