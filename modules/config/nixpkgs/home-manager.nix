{
  den,
  lib,
  ...
}: {
  den.schema.host = {
    includes = [den.aspects.home-manager-shared];

    options.sharedHomePkgs = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  den.aspects.home-manager-shared.os = {host, ...}: {
    home-manager.useGlobalPkgs = host.sharedHomePkgs;
    home-manager.useUserPackages = true;
  };

  den.policies.project-user-overlays = {
    user,
    host,
    ...
  }:
    lib.optionals host.sharedHomePkgs [
      (den.lib.policy.pipe.from "nixpkgs-overlays" [den.lib.policy.pipe.expose])
    ];

  den.schema.user.includes = [den.policies.project-user-overlays];
}
