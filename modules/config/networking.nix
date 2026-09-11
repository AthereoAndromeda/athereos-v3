{lib, ...}: {
  den.aspects.networking.default = {
    nixos = {
      # Incompatible with Docker
      # https://mynixos.com/nixpkgs/option/networking.nftables.enable
      networking.nftables.enable = lib.mkDefault true;

      # Configure network connections interactively with nmcli or nmtui.
      networking.networkmanager.enable = lib.mkDefault true;

      networking.nameservers = ["192.168.1.1" "fe80::1%wlp2s0" "1.1.1.1" "8.8.8.8"];
      networking.networkmanager.dns = "none";
    };
  };
}
