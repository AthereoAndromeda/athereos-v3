{pkgs, ...}: {
  # home.packages = with pkgs; [ ];

  dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
}
