# UP.md
This file contains runnable blocks
meant to be ran by `upmd`

# Build
Build commands

## Switch
Rebuild and activate the system
```sh [name:switch, deps:fmt]
sudo nixos-rebuild --flake . switch
```

## Test
Test the system
```sh [name:test, deps:fmt]
sudo nixos-rebuild --flake . test
```

## Build
Build the system but do not activate it
```sh [name:build, deps:fmt]
sudo nixos-rebuild --flake . build
```


# Utilities
## Format
Format nix files
```sh [name:fmt]
alejandra .
```

## List
List NixOS generations
```sh [name:list]
nixos-rebuild list-generations
```

## Diff
Get the differences between each nix generation
```sh [name:diff, deps:fmt]
nix profile diff-closures --profile /nix/var/nix/profiles/system
```

## Clean
Clean nix store
```sh [name:clean]
sudo nix-collect-garbage --delete-older-than "3d"
```

## Optimize
Optimize and compresses nix store. This may take a long while.
```sh [name:opt]
nix-store --optimise --verbose
```
