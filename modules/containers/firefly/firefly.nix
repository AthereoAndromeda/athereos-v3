{den, ...}: {
  den.aspects.containers.firefly = {
    includes = [den.aspects.containers];
    persist.directories = ["/var/lib/nixos-containers/firefly"];

    nixos.containers.firefly = import ./_firefly-container.nix;
  };
}
