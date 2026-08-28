{den, ...}: {
  den.aspects.containers.firefly = {
    includes = [den.aspects.containers];
    persist.directories = ["/var/lib/nixos-containers/firefly"];

    nixos = let
      key-path = "/var/lib/firefly/app-key.txt";
    in {
      sops.secrets."firefly/app-key" = {
        mode = "0444";
        path = key-path;
      };

      containers.firefly = import ./_firefly-container.nix key-path;
    };
  };
}
