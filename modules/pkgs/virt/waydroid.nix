{...}: {
  den.aspects.pkgs.waydroid = {
    nixos = {...}: {
      virtualisation.waydroid = {
        enable = true;
      };
    };
  };
}
