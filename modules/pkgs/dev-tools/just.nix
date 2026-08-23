{den, ...}: {
  dev-tools.just = den.aspects.pkgs.just;

  den.aspects.pkgs.just = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.just pkgs.just-lsp];
    };
  };
}
