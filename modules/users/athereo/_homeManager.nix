{pkgs, ...}: {
  home.packages = with pkgs; [
    motrix
    motrix-next
  ];

  dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
}
