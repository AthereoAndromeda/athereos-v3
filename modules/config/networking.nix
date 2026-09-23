{lib, ...}: {
  den.aspects.networking.default = {
    nixos = {
      # Incompatible with Docker
      # https://mynixos.com/nixpkgs/option/networking.nftables.enable
      networking.nftables.enable = lib.mkDefault true;

      # Configure network connections interactively with nmcli or nmtui.
      networking.networkmanager.enable = lib.mkDefault true;

      specialisation.no-local-dns.configuration = {
        networking.nameservers = ["1.1.1.1" "8.8.8.8"];
        networking.networkmanager.dns = "none";
      };
    };
  };
}
