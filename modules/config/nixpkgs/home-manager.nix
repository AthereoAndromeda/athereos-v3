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

  den.aspects.home-manager-shared = {
    os = {host, ...}: {
      home-manager.useGlobalPkgs = host.sharedHomePkgs;
      home-manager.useUserPackages = true;
    };
  };

  # Expose home-manager overlays to host
  den.policies.project-user-overlays = {
    user,
    host,
    ...
  }: let
    inherit (den.lib.policy) pipe;
  in
    lib.optionals host.sharedHomePkgs [
      (pipe.from "nixpkgs-overlays" [pipe.expose])
    ];

  den.schema.user.includes = [den.policies.project-user-overlays];
}
