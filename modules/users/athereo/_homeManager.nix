{pkgs, ...}: {
  home.packages = with pkgs; [
    chromium
    super-productivity

    motrix
    motrix-next
  ];

  dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
}
