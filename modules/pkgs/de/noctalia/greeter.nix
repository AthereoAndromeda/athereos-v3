{...}: {
  den.aspects.noctalia-greeter = {
    persist.directories = ["/var/lib/noctalia-greeter"];

    nixos = {pkgs, ...}: {
      # Requires nixpkgs-unstable
      services.displayManager.noctalia-greeter = {
        enable = true;

        settings = {
          cursor.size = 24;
        };

        cursorTheme = {
          package = pkgs.lyra-cursors;
          name = "LyraQ-cursors";
        };
      };
    };
  };
}
