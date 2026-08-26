{...}: {
  den.aspects.printing = {
    user.extraGroups = ["lpadmin"];

    nixos = {pkgs, ...}: {
      services.printing = {
        # Enable CUPS to print documents.
        enable = true;
        drivers = with pkgs; [
          gutenprint
          cups-filters
          cups-browsed
          hplip

          # Unfree
          gutenprint-bin
          hplipWithPlugin
        ];
      };

      services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };

      services.ipp-usb.enable = true;
    };
  };
}
