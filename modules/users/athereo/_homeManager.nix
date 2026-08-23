{pkgs, ...}: {
  services.espanso = {
    enable = true;
    configs = {
      default = {
        undo_backspace = true;
      };
    };
  };

  services.cliphist.enable = true;
  home.packages = with pkgs; [
    chromium
    super-productivity

    motrix
    motrix-next
  ];

  dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  programs.carapace = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
  };
}
