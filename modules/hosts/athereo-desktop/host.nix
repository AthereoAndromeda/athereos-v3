{
  den,
  hardware,
  remote-build,
  gaming,
  ...
}: let
  hostname = "athereo-desktop";
in {
  den.hosts.x86_64-linux.${hostname} = {
    users.athereo = {};
  };

  den.aspects.${hostname} = {
    includes = [
      remote-build.builder
      hardware.zswap
      hardware.amd
    ];

    ssh-keys.athereo = [./ssh/id_ed25519-athereo.pub];

    nixos = {
      imports = [
        ./_configuration.nix
        ./_hardware-configuration.nix
        ./_impermanence.nix
      ];
    };

    provides.to-users = {
      includes =
        (with den.aspects; [
          impermanence
          # containers.firefly
          # containers.freshrss
        ])
        ++ [
          gaming.zeroad
          gaming.veloren
        ];

      user.extraGroups = ["tss"];
    };
  };
}
