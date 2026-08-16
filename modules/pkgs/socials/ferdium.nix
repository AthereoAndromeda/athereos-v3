{...}: {
  den.aspects.pkgs.ferdium = {
    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.ferdium];
    };

    persist.home.directories = [
      ".config/Ferdium"
    ];
  };
}
