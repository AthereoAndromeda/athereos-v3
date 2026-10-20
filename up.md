# UP.md
This file contains runnable blocks
meant to be ran by `upmd`

# Build
Build commands

## Switch
Rebuild and activate the system
```sh [name:switch, deps:fmt]
nh os switch . -e run0
```

## Test
Test the system
```sh [name:test, deps:fmt]
nh os test . -e run0
```

## Build
Build the system but do not activate it
```sh [name:build, deps:fmt]
nh os build . -e run0
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
nh os info
```

## Diff
Get the differences between each nix generation
```sh [name:diff, deps:fmt]
nix profile diff-closures --profile /nix/var/nix/profiles/system
```

## Clean
Clean nix store
```sh [name:clean]
nh clean all --keep-one -K "7d"
```

## Optimize
Optimize and compresses nix store. This may take a long while.
```sh [name:opt]
nix-store --optimise --verbose
```
