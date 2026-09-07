{...}: {
  dev-tools.serie = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.serie];
    };
  };
}
