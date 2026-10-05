{
  den,
  dev-tools,
  ...
}: {
  den.aspects.admin = {
    includes =
      [
        dev-tools.zellij
        dev-tools.jujutsu
        dev-tools.lua
        dev-tools.python
      ]
      ++ (with den.batteries; [
        define-user
      ])
      ++ (with den.aspects; [
        virtualisation
        pkgs.just
        pkgs.yazi
        pkgs.shells
        pkgs.zoxide
        pkgs.starship
        security.tor
        security.sops
        security.kryptor
        security.cert
      ]);

    # Provided by den.batteries.os-user
    user = {
      hashedPasswordFile = "/persist/password/athereo";
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "audio"
        "networkmanager"
        "video"
        "render"
        "cdrom"
        "adm"
        "lpadmin"
        "input"
        "plugdev"
        "libvirtd"
        "dialout"
        "uucp"
      ];

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICdcG95VgwY0vPHJqOrLQRuHy1C52pvJUioQOVJsTojd athereo@athereo-nixos-ideapad"
      ];
    };

    homeManager = import ./_homeManager.nix;
    nixos = import ./_nixos.nix;
  };
}
