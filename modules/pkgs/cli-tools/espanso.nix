{...}: {
  den.aspects.pkgs.espanso = {
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
