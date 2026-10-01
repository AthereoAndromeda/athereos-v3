{
  den,
  inputs,
  remote-build,
  ...
}: {
  den.hosts.x86_64-linux.athereo-nixos-ideapad.users.athereo = {};

  den.aspects.athereo-nixos-ideapad = {
    includes = with den.aspects; [
      scripts.lenovoctl
      containers.firefly
      containers.freshrss
      remote-build.builder
    ];

    user.extraGroups = ["tss"];

    nixos = {pkgs, ...}: {
      imports = [inputs.nixos-hardware.nixosModules.lenovo-ideapad-16ahp9];

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
    };

    provides.to-users = {user, ...}: {
      includes = [den.aspects.impermanence];

      nixos = {
        users.groups.lenovoctl = {};
        users.users.${user.name} = {
          extraGroups = ["lenovoctl"];
        };
      };
    };
  };
}
