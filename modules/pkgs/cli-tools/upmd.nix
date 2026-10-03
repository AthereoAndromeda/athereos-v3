{inputs, ...}: {
  den.aspects.pkgs.upmd = {
    nixpkgs-overlays = _: [inputs.upmd.overlays.default];

    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.upmd];
    };
  };
}
