{...}: {
  den.aspects.pkgs.simplex-chat = {
    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.simplex-chat-desktop];
    };

    persist.home.directories = [
      ".local/share/simplex"
      ".config/simplex"
    ];
  };
}
