set dotenv-load
set shell := ["nu", "-c"]

alias fmt := format
alias s := switch
alias t := test
alias b := boot
alias l := list
alias td := test-debug
alias up := update
alias upc := update-ci
alias opt := optimise
alias rm := delete-generations
alias rmr := delete-generations-range

net := "true"
rebuild-opts := if net == "true" { "" } else { "--no-net --offline" }
profile-flag := "--profile /nix/var/nix/profiles/system"

default:
    just --list
    # just --choose

# Build in `build` mode.
[group('build')]
build: format _git-add
    sudo nixos-rebuild --flake . build

# Build in `switch` mode and add the generation to the bootloader
[group('build')]
switch: format _git-add
     sudo nixos-rebuild --flake . {{ rebuild-opts }} switch

# Build in `test` mode
[group('build')]
test: format _git-add
     sudo nixos-rebuild --flake . test

# Build in `boot` mode
[group('build')]
boot: format _git-add
     sudo nixos-rebuild --flake . boot

# Build in `test` mode, with lots of debug flags
[group('build')]
test-debug eval-cache="true": format _git-add
     sudo nixos-rebuild --flake . --option eval-cache {{eval-cache}} --show-trace --print-build-logs --verbose test


# Format all `.nix` files using Alejandra
[group('lints')]
format:
    alejandra . 

# Update Nix Flakes
[group('nix/utils')]
update *deps:
    nix flake update {{deps}}
   
# Update Nix Flakes, Test, Commit
[group('nix/utils')]
update-ci *deps: _git-add
    nix flake update --commit-lock-file {{deps}}

# Cleans nix garbage
[group('nix/utils')]
clean older-than="7d":
     sudo nix-collect-garbage --delete-older-than "{{older-than}}"

# Cleans old nix garbage
[group('nix/utils')]
clean-old:
     sudo nix-collect-garbage --delete-old

# Lists all Nix Generations
[group('nix/utils')]
list:
   nixos-rebuild list-generations 

[group('nix/utils')]
diff:
    nix profile diff-closures {{profile-flag}}
    
# Delete specified generations
[group('nix/utils')]
delete-generations +gen:
    sudo nix-env {{profile-flag}} --delete-generations {{gen}}
    
# Delete specified generations
[group('nix/utils')]
delete-generations-range range:
     sudo nix-env {{profile-flag}} --delete-generations ...({{range}} | each {|it| $it})

# Optimize and compresses nix store. This may take a long while.
[group('nix/utils')]
optimise:
    nix-store --optimise --verbose

# Searches through all files for TODO:
[group('utils')]
todo:
    rg -g '!Justfile' -g '!todo.md' -i "(?-i)TODO"
    
# Searches through all files for FIX or FIXME:
[group('utils')]
fix:
    rg -g '!Justfile' -g '!todo.md' -i "(?-i)FIX(ME)?"

_git-add:
    @git add .
