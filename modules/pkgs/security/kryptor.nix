{...}: {
  den.aspects.security.kryptor = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.kryptor];
    };
  };
}
