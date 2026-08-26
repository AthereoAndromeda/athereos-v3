{lib, ...}: {
  den.aspects.cursors.lyra-q = {
    homeManager = {
      pkgs,
      config,
      ...
    }: {
      home.sessionVariables = {
        XCURSOR_THEME = config.home.pointerCursor.name;
        XCURSOR_SIZE = lib.toString config.home.pointerCursor.size;
      };

      home.pointerCursor = {
        enable = true;
        gtk.enable = true;
        package = pkgs.lyra-cursors;
        name = "LyraQ-cursors";
        size = 48;
      };
    };
  };
}
