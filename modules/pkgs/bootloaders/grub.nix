{
  den,
  inputs,
  ...
}: {
  den.aspects.boot.grub = {
    includes = [den.aspects.boot];

    # TODO: Switchable GRUB Themes through options
    # TODO: Switch bootloaders through options
    nixos = {pkgs, ...}: let
      hyperfluent-theme = import ./themes/_hyperfluent.nix {inherit pkgs inputs;};
    in {
      boot.loader.grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
        # theme = hyperfluent-theme;
      };
    };
  };
}
