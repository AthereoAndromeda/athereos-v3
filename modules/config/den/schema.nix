{
  lib,
  den,
  ...
}: {
  den.schema.host.imports = [
    {
      options.settings = lib.mkOption {
        type = import ./_settings-type.nix {inherit den lib;};
        default = {};
        description = "Per-aspect typed settings";
      };
    }
  ];
}
# Usage
# den.aspects.kernel = {
#   settings.variant = lib.mkOption {
#     type = lib.types.enum [ "lts" "latest" ];
#     default = "latest";
#     description = "Kernel release line";
#   };
#   nixos = { host, pkgs, ... }:
#     let cfg = host.settings.kernel; in {
#       boot.kernelPackages =
#         if cfg.variant == "lts" then pkgs.linuxPackages
#         else pkgs.linuxPackages_latest;
#     };
# };
# den.hosts.x86_64-linux.igloo = {
#   users.tux = { };
#   settings.kernel.variant = "lts";
# };
# den.aspects.igloo.includes = [ den.aspects.kernel ];

