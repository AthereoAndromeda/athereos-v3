{
  inputs,
  den,
  ...
}: {
  # den.hosts.x86_64-linux.nixos-server.users.athereo = {};
  den.hosts.x86_64-linux.nixos-server = {
    channel = "nixos-stable";
    users.admin = {};
  };

  den.aspects.nixos-server = {
    excludes = with den.aspects; [security.rns];
    nixos = {...}: {
      imports = [./_configuration.nix];
    };

    provides.to-users = {...}: {
      # includes = [den.aspects.impermanence];
    };
  };
}
