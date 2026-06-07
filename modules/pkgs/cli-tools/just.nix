{...}: {
  den.aspects.pkgs.just = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.just pkgs.just-lsp];
    };
  };
}
