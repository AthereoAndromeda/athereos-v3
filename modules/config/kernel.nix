{
  inputs,
  den,
  ...
}: {
  den.aspects.kernel = {
    nixpkgs-overlays = _: [inputs.nix-cachyos-kernel.overlays.pinned];
  };

  den.default.includes = [den.aspects.kernel];
}
