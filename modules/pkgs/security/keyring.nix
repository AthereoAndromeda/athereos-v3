{...}: {
  den.aspects.keyring.nixos = {
    services.gnome.gnome-keyring.enable = true;
    programs.seahorse.enable = true;
  };
}
