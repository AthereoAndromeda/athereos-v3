{
  den,
  inputs,
  ...
}: {
  den.hosts.x86_64-linux.athereo-nixos-ideapad.users.athereo = {};

  den.aspects.hardware.athereo-nixos-ideapad = {
    includes = [den.aspects.impermanence];

    nixos = {...}: {
      imports = [inputs.nixos-hardware.nixosModules.lenovo-ideapad-16ahp9];
      networking.hostName = "athereo-nixos-ideapad"; # Define your hostname.
    };
  };
}
