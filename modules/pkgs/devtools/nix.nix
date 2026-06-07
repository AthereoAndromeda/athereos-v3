{...}: {
  den.aspects.nix-tools.nixos = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [alejandra nixd];
  };
}
