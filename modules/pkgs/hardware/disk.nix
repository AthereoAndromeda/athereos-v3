{...}: {
  den.aspects.disk.nixos = {pkgs, ...}: {
    environment.systemPackages = [pkgs.smartmontools];
  };
}
