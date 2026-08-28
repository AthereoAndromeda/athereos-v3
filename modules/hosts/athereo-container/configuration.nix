{
  den,
  dev-tools,
  lib,
  ...
}: {
  den.hosts.x86_64-linux.athereo-container.users.admin = {};

  den.aspects.athereo-container = {
    excludes = with den.aspects;
      [
        lix
        unfree
        hardware-utils
        boot
        boot.grub
        security.keyring
        security.polkit
        security.gnupg
        security.sops
        pkgs.cli-tools
        pkgs.shells
        pkgs.terminals
        pkgs.yazi
        pkgs.helix
        pkgs.fonts
        pkgs.fastfetch
        pkgs.git
        containers.firefly
      ]
      ++ [
        den.batteries.inputs'
        den.batteries.self'
        dev-tools.nix
        dev-tools.utils
      ];

    # user = {
    #   isSystemUser = true;
    #   extraGroups = ["admin"];
    # };

    nixos = {pkgs, ...}: {
      boot.isContainer = true;

      users.groups.admin = {};
      users.users.admin = {
        isSystemUser = true;
        group = "admin";
      };

      networking.firewall.allowedTCPPorts = [80];

      services.httpd = {
        enable = true;
        adminAddr = "morty@example.org";
      };
    };

    provides.to-users = {
      excludes = with den.aspects;
        [
          lix
          unfree
          hardware-utils
          boot
          boot.grub
          security.keyring
          security.polkit
          security.gnupg
          security.sops
          pkgs.cli-tools
          pkgs.shells
          pkgs.terminals
          pkgs.yazi
          pkgs.helix
          pkgs.fonts
          pkgs.fastfetch
          pkgs.git
          containers.firefly
        ]
        ++ [
          den.batteries.inputs'
          den.batteries.self'
          dev-tools.nix
          dev-tools.utils
        ];

      homeManager = {
        gitEmail = "whatevs";
        gitName = "broh";
      };
    };
  };
}
