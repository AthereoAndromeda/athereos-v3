{...}: {
  den.aspects.grub = {
    nixos = {...}: {
      boot.loader.grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
      };
    };
  };
}
