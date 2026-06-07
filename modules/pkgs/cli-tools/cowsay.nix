{...}: {
  den.aspects.pkgs.cowsay = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.cowsay];
    };
  };
}
