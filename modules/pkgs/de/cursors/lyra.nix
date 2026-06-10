{...}: {
  den.aspects.cursors.lyra-q = {
    homeManager = {
      pkgs,
      config,
      ...
    }: {
      home.sessionVariables = {
        XCURSOR_THEME = "LyraQ-cursors";
        XCURSOR_SIZE = "48";
      };

      home.pointerCursor = {
        enable = true;
        gtk.enable = true;
        package = pkgs.lyra-cursors;
        name = config.home.sessionVariables.XCURSOR_THEME;
        size = config.home.sessionVariables.XCURSOR_SIZE;
      };
    };
  };
}
