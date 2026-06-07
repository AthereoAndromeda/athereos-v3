{...}: {
  den.aspects.security.gnupg = {
    nixos = {
      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
  };
}
