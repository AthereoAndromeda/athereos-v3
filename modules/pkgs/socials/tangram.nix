{...}: {
  den.aspects.pkgs.tangram = {
    persist.home.data.directories = ["Tangram"];
    persist.home.config.directories = ["Tangram"];

    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.tangram];
    };
  };
}
