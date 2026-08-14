{...}: {
  den.aspects.security.gnupg = {
    nixos = {
      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };

    persist.home.directories = [
      {
        directory = ".gnupg";
        mode = "0700";
      }
    ];
  };
}
