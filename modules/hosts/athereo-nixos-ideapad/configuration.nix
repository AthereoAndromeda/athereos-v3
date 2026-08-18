{
  den,
  inputs,
  ...
}: {
  den.hosts.x86_64-linux.athereo-nixos-ideapad.users.athereo = {};

  den.aspects.hardware.athereo-nixos-ideapad = {
    includes = [den.aspects.impermanence];

    nixos = {
      pkgs,
      user,
      ...
    }: {
      imports = [inputs.nixos-hardware.nixosModules.lenovo-ideapad-16ahp9];
      networking.hostName = "athereo-nixos-ideapad"; # Define your hostname.

      users.groups.lenovoctl = {};
      users.users.${user.name} = {
        extraGroups = ["lenovoctl"];
      };

      services.udev.extraRules = ''
        ACTION=="add|change", SUBSYSTEM=="platform", DRIVER=="ideapad_acpi", RUN+="${pkgs.coreutils}/bin/chgrp lenovoctl /sys%p/conservation_mode", RUN+="${pkgs.coreutils}/bin/chmod 664 /sys%p/conservation_mode"
      '';
    };
  };
}
