{
  den,
  hardware,
  inputs,
  remote-build,
  ...
}: {
  den.hosts.x86_64-linux.athereo-nixos-ideapad = {
    sharedHomePkgs = true;
    users.athereo = {};
  };

  den.aspects.athereo-nixos-ideapad = {
    includes = with den.aspects;
      [
        scripts.lenovoctl
      ]
      ++ [
        den.aspects.hardware.zswap
        remote-build.builder
        hardware.amd
      ];

    nixos = {
      imports = [
        inputs.nixos-hardware.nixosModules.lenovo-ideapad-16ahp9
        ./_configuration.nix
        ./_hardware-configuration.nix
        ./_impermanence.nix
      ];
    };

    provides.to-users = {
      includes = with den.aspects; [
        impermanence
        containers.firefly
        containers.freshrss
      ];

      user.extraGroups = ["lenovoctl" "tss"];
      nixos.users.groups.lenovoctl = {};
    };
  };
}
