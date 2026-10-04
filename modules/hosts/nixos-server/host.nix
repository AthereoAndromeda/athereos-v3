{den, ...}: {
  den.hosts.x86_64-linux.nixos-server = {
    channel = "nixos-stable";
    users.admin = {};
  };

  den.aspects.nixos-server = {
    includes = with den.aspects; [hardware.swap];
    excludes = with den.aspects; [security.rns];

    nixos = {
      imports = [
        ./_configuration.nix
        ./_hardware-configuration.nix
      ];
    };

    provides.to-users = {...}: {
      # includes = [den.aspects.impermanence];
    };
  };
}
