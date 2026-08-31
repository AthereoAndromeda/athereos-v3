{...}: {
  dev-tools.julia = {
    persist.home.directories = [".julia"];

    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.julia-bin];
    };
  };
}
