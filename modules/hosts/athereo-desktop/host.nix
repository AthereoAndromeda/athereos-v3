{
  den,
  hardware,
  remote-build,
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
      den.aspects.hardware.zswap
      hardware.amd
    ];

    nixos = {
      imports = [
        ./_configuration.nix
        ./_hardware-configuration.nix
        ./_impermanence.nix
      ];
    };

    provides.to-users = {
      includes = with den.aspects; [
        impermanence
        # containers.firefly
        # containers.freshrss
      ];

      user.extraGroups = ["tss"];
    };
  };
}
