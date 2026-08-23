{...}: {
  dev-tools.python = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.python3];
    };
  };
}
