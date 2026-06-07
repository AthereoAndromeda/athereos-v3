{...}: {
  den.aspects.pkgs.usb-utils = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.usbutils];
    };
  };
}
