{
  den,
  hardware,
  dev-tools,
  gaming,
  ...
}: {
  den.aspects.athereo = {
    includes =
      [
        hardware.printing
        dev-tools.direnv
        dev-tools.zellij
        dev-tools.jujutsu
        dev-tools.lua
        dev-tools.python
        dev-tools.julia
        dev-tools.devenv
        dev-tools.embedded
        gaming.prism
        gaming.steam
      ]
      ++ (with den.batteries; [
        define-user
        primary-user
      ])
      ++ (with den.aspects; [
        office
        xremap
        xdg-utils
        virtualisation
        de.niri
        udev.probe-rs
        pkgs.waydroid
        pkgs.zen-browser
        pkgs.chromium
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
        pkgs.motrix
        security.tor
        security.sops
        security.kryptor
        security.rns
        security.cert
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
        "input"
        "libvirtd"
        "dialout"
        "uucp"
      ];
    };

    homeManager = import ./_homeManager.nix;
    nixos = import ./_nixos.nix;

    persist.home.files = [".face"];
  };
}
