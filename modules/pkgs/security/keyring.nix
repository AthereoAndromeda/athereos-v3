{...}: {
  den.aspects.security.keyring = {
    nixos = {
      services.gnome.gnome-keyring.enable = true;
      programs.seahorse.enable = true;
    };

    persist.home.directories = [
      {
        directory = ".local/share/keyrings";
        mode = "0700";
      }
    ];
  };
}
