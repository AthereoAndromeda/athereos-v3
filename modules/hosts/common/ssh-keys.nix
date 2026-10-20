{
  lib,
  den,
  ...
}: {
  den.quirks.ssh-keys.description = "Public SSH keys for each user";

  den.policies.expose-ssh-keys = {user, ...}: let
    inherit (den.lib.policy) pipe;
  in [
    (pipe.from "ssh-keys" [
      (pipe.collectAll ({host, ...}: true))
      (pipe.filter (e: e ? ${user.name}))
      (pipe.for (e: lib.concatMap (x: x.${user.name}) e))
    ])
  ];

  den.schema.user.includes = [den.policies.expose-ssh-keys];
}
