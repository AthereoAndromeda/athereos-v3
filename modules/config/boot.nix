{...}: {
  den.aspects.boot.nixos = {
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
