{pkgs, ...}: {
  # Cachy Kernel
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;

  services.udev.extraRules = ''
    ACTION=="add|change", SUBSYSTEM=="platform", DRIVER=="ideapad_acpi", RUN+="${pkgs.coreutils}/bin/chgrp lenovoctl /sys%p/conservation_mode", RUN+="${pkgs.coreutils}/bin/chmod 664 /sys%p/conservation_mode"
  '';

  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
    tctiEnvironment.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Tablet
    wvkbd
    lisgd
  ];

  services.xserver.wacom.enable = true;
  hardware.opentabletdriver.enable = true;

  nix.distributedBuilds = true;
  nix.settings.builders-use-substitutes = true;

  nix.buildMachines = [
    {
      # hostName = "athereo-desktop";
      hostName = "athereo-desktop";
      sshUser = "remotebuild";
      sshKey = "/root/.ssh/remotebuild";
      protocol = "ssh-ng";
      system = pkgs.stdenv.hostPlatform.system;
      supportedFeatures = [
        "nixos-test"
        "benchmark"
        "big-parallel"
        "kvm"
        "gccarch-znver3"
        "gccarch-x86-64-v3"
        "gccarch-x86-64-v2"
        "gccarch-x86-64"
      ];
    }
  ];
}
