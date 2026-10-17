{...}: {
  gaming.veloren = {
    persist.home.data.directories = ["airshipper"];

    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.airshipper];
    };
  };
}
