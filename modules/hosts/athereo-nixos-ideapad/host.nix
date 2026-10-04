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
        remote-build.builder
      ]
      ++ [
        den.aspects.hardware.zswap
        hardware.amd
      ];

    user.extraGroups = ["tss"];

    nixos = {
      imports = [
        inputs.nixos-hardware.nixosModules.lenovo-ideapad-16ahp9
        ./_configuration.nix
        ./_hardware-configuration.nix
        ./_impermanence.nix
      ];
    };

    provides.to-users = {user, ...}: {
      includes = with den.aspects;
        [
          containers.firefly
          containers.freshrss
        ]
        ++ [den.aspects.impermanence];

      nixos = {
        users.groups.lenovoctl = {};
        users.users.${user.name} = {
          extraGroups = ["lenovoctl"];
        };
      };
    };
  };
}
