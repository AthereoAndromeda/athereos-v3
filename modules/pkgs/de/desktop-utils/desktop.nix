{...}: {
  den.aspects.desktop-utils = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        playerctl
        libnotify
        brightnessctl
      ];
    };
  };
}
