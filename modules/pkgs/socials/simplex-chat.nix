{...}: {
  den.aspects.pkgs.simplex-chat = {
    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.simplex-chat-desktop];
    };

    persist.home.config.directories = ["simplex"];
    persist.home.data.directories = ["simplex"];
  };
}
