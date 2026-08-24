{
  den,
  dev-tools,
  gaming,
  ...
}: {
  den.aspects.athereo = {
    includes =
      [
        dev-tools.direnv
        dev-tools.zellij
        dev-tools.lua
        dev-tools.python
        gaming.prism
        gaming.steam
      ]
      ++ (with den.batteries; [
        define-user
        primary-user
      ])
      ++ (with den.aspects; [
        office
        grub
        xremap
        xdg-utils
        virtualisation
        printing
        de.niri
        udev.probe-rs
        pkgs.zen-browser
        pkgs.localsend
        pkgs.just
        pkgs.yazi
        pkgs.shells
        pkgs.socials
        pkgs.zoxide
        pkgs.media-tools
        pkgs.starship
        pkgs.productivity-tools
        pkgs.hyfetch
        security.tor
        security.sops
        security.kryptor
        scripts.find-desktop
      ]);

    excludes = [
      # Uses Noctalia's polkit
      den.aspects.security.polkit
    ];

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
    };

    homeManager = import ./_homeManager.nix;
    nixos = import ./_nixos.nix;
  };
}
