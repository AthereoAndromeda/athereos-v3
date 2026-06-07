{den, ...}: {
  den.aspects.hardware-utils = {
    includes = with den.aspects; [
      bluetooth
      graphics
      pkgs.usb-utils
    ];

    nixos = {...}: {
      hardware.enableAllHardware = true;
      hardware.enableRedistributableFirmware = true;
      hardware.amdgpu.opencl.enable = true;
    };
  };
}
