{
  inputs,
  den,
  ...
}: {
  imports = [(inputs.den.namespace "hardware" false)];

  hardware.default = den.aspects.hardware-utils;

  den.aspects.hardware-utils = {
    includes = with den.aspects; [
      bluetooth
      graphics
      disk
      pkgs.usb-utils
    ];

    nixos = {...}: {
      hardware.enableAllHardware = true;
      hardware.enableRedistributableFirmware = true;
    };
  };
}
