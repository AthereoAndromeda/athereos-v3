{
  inputs,
  den,
  ...
}: {
  den.aspects.kernel = {
    nixpkgs-overlays = _: [inputs.nix-cachyos-kernel.overlays.pinned];

    nixos = {
      nix.settings.substituters = ["https://cache.lantian.pub/lantian"];
      nix.settings.trusted-public-keys = ["lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ="];
    };
  };

  den.default.includes = [den.aspects.kernel];
}
