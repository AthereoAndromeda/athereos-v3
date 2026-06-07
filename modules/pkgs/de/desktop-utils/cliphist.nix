{...}: {
  den.aspects.desktop.cliphist = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.wl-clipboard-rs];
    };
    homeManager.services.cliphist.enable = true;
  };
}
