{inputs, ...}: {
  den.aspects.pkgs.upmd = {
    nixos = {pkgs, ...}: {
      nixpkgs.overlays = [inputs.upmd.overlays.default];
      environment.systemPackages = [pkgs.upmd];
    };
  };
}
