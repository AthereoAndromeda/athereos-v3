{...}: {
  den.aspects.pkgs.libreoffice = {
    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.libreoffice];
    };
  };
}
