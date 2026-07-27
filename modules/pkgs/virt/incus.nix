{...}: {
  den.aspects.virtualisation = {
    nixos = {user, ...}: {
      virtualisation.incus = {
        enable = true;
        ui.enable = true;
      };

      users.users.${user.name}.extraGroups = ["incus-admin"];

      # Incompatible with Docker
      # https://mynixos.com/nixpkgs/option/networking.nftables.enable
      networking.nftables.enable = true;
    };
  };
}
