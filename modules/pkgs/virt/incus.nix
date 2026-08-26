{...}: {
  den.aspects.virtualisation = {
    nixos = {user, ...}: {
      virtualisation.incus = {
        enable = true;
        ui.enable = true;
      };

      users.users.${user.name}.extraGroups = ["incus-admin"];
    };
  };
}
