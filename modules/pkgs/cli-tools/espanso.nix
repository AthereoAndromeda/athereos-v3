{...}: {
  den.aspects.pkgs.espanso.homeManager = {
    services.espanso = {
      enable = true;
      configs = {
        default = {
          undo_backspace = true;
        };
      };
    };
  };
}
