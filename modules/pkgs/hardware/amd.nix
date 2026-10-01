{hardware, ...}: {
  hardware.amd = {
    includes = [hardware.default];

    nixos = {
      hardware.amdgpu.opencl.enable = true;
    };
  };
}
