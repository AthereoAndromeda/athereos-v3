{...}: {
  den.aspects.pkgs.simplex-chat = {
    homeManager = {pkgs, ...}: {
      home.packages = [pkgs.simplex-chat-desktop];
    };
  };

  den.aspects.impermanence.nixos = {user, ...}: {
    environment.persistence."/persist" = {
      users.${user.name} = {
        directories = [
          ".local/share/simplex"
          ".config/simplex"
        ];
      };
    };
  };
}
