{
  den,
  inputs,
  lib,
  ...
}: {
  imports = [inputs.den.flakeModule];

  den.schema.user.classes = lib.mkDefault ["homeManager"];

  den.default.includes = with den.aspects; [
    hardware-utils
    nix-tools
    keyring
    polkit
    security.gnupg
    pkgs.cli-tools
    pkgs.shells
    pkgs.terminals
    pkgs.yazi
    pkgs.helix
    pkgs.fonts
    pkgs.fastfetch
    pkgs.git
  ];

  den.default.homeManager = {
    home.stateVersion = "26.05";
  };

  den.default.nixos = {pkgs, ...}: {
    nixpkgs.overlays = [
      (final: prev: {
        inherit
          (prev.lixPackageSets.stable)
          nixpkgs-review
          nix-eval-jobs
          nix-fast-build
          colmena
          ;
      })
    ];

    nix.package = pkgs.lixPackageSets.stable.lix;
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "hm-backup";
    };

    environment.systemPackages = with pkgs; [
      btop
      vim
      firefox
    ];

    # Use the systemd-boot EFI boot loader.
    # boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Configure network connections interactively with nmcli or nmtui.
    networking.networkmanager.enable = lib.mkDefault true;

    # Enable the X11 windowing system.
    services.xserver.enable = lib.mkDefault true;
    programs.xwayland.enable = lib.mkDefault true;

    # Enable touchpad support (enabled default in most desktopManager).
    services.libinput.enable = lib.mkDefault true;

    # Enable CUPS to print documents.
    services.printing.enable = lib.mkDefault true;

    services.dbus.implementation = lib.mkDefault "broker";

    # Enable sound.
    # services.pulseaudio.enable = true;
    # OR
    services.pipewire = {
      enable = lib.mkDefault true;
      pulse.enable = lib.mkDefault true;
    };

    # Note, if you use the NixOS module and have useUserPackages = true, make sure to add
    environment.pathsToLink = lib.mkDefault [
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];

    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
    #
    # Most users should NEVER change this value after the initial install, for any reason,
    # even if you've upgraded your system to a new NixOS release.
    #
    # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
    # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
    # to actually do that.
    #
    # This value being lower than the current NixOS release does NOT mean your system is
    # out of date, out of support, or vulnerable.
    #
    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "26.05"; # Did you read the comment?

    nix.settings.experimental-features = ["nix-command" "flakes"];
  };
}
