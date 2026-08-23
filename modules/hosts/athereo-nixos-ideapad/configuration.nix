{
  den,
  inputs,
  ...
}: {
  den.hosts.x86_64-linux.athereo-nixos-ideapad.users.athereo = {};

  den.aspects.athereo-nixos-ideapad = {
    includes = with den.aspects; [
      scripts.lenovoctl
    ];

    nixos = {pkgs, ...}: {
      imports = [inputs.nixos-hardware.nixosModules.lenovo-ideapad-16ahp9];

      services.udev.extraRules = ''
        ACTION=="add|change", SUBSYSTEM=="platform", DRIVER=="ideapad_acpi", RUN+="${pkgs.coreutils}/bin/chgrp lenovoctl /sys%p/conservation_mode", RUN+="${pkgs.coreutils}/bin/chmod 664 /sys%p/conservation_mode"
      '';
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
