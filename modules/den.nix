{
  den,
  dev-tools,
  inputs,
  self,
  lib,
  ...
}: {
  imports = [inputs.den.flakeModule];

  den.schema.user.classes = lib.mkDefault ["homeManager"];
  den.schema.flake-system.includes = [
    den.policies.packages-to-flake-parts
    den.policies.system-to-flake-parts
  ];

  den.default.includes = with den.aspects;
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
      den.batteries.hostname
      den.batteries.inputs'
      den.batteries.self'
      dev-tools.nix
      dev-tools.utils
    ];

  den.default.homeManager = {
    home.stateVersion = "26.05";
  };

  den.default.nixos = {
    pkgs,
    config,
    ...
  }: {
    nixpkgs.overlays = [
      inputs.nuenv.overlays.default
    ];

    # Linux 7.2
    boot.kernelPackages = pkgs.linuxKernel.packages.linux_7_2;

    specialisation.stable.configuration = {
      system.nixos.tags = ["stable"];
      boot.kernelPackages = lib.mkForce pkgs.linuxPackages;
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "hm-backup";
    };

    programs.nix-ld = {
      enable = true;
    };

    environment.systemPackages = with pkgs; [
      btop
      vim
      wget
      firefox
    ];

    # Incompatible with Docker
    # https://mynixos.com/nixpkgs/option/networking.nftables.enable
    networking.nftables.enable = lib.mkDefault true;

    # Configure network connections interactively with nmcli or nmtui.
    networking.networkmanager.enable = lib.mkDefault true;

    # Enable the X11 windowing system.
    services.xserver.enable = lib.mkDefault true;
    services.xserver.videoDrivers = lib.mkDefault ["nvidia" "amdgpu" "modesetting" "fbdev"];
    programs.xwayland.enable = lib.mkDefault true;

    # Enable touchpad support (enabled default in most desktopManager).
    services.libinput.enable = lib.mkDefault true;

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

    # Set your time zone.
    time.timeZone = lib.mkDefault "Asia/Manila";

    # Prevent dual boot Windows breaking the time
    time.hardwareClockInLocalTime = lib.mkDefault true;

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

    system.configurationRevision = self.rev or self.dirtyRev or null;
    nix.settings.trusted-users = ["root" "@wheel"];

    sops.secrets."nix-settings/access-tokens/github" = {
      reloadUnits = ["nix-daemon.service"];
      owner = "root";
      group = "root";
      mode = "0400";
    };

    sops.templates."nix-access-tokens.conf" = let
      access-token-content = tokens: "access-token = ${lib.concatStringsSep " " tokens}";
    in {
      content = access-token-content [config.sops.placeholder."nix-settings/access-tokens/github"];
    };

    nix.extraOptions = ''
      !include ${config.sops.templates."nix-access-tokens.conf".path}
    '';

    nix.settings.experimental-features = ["nix-command" "flakes"];
    # Hardware-optimized for v3
    nix.settings.system-features = [
      "nixos-test"
      "benchmark"
      "big-parallel"
      "kvm"
      "gccarch-znver3"
      "gccarch-x86-64-v3"
      "gccarch-x86-64-v2"
      "gccarch-x86-64"
    ];

    # nixpkgs.hostPlatform = {
    #   system = "x86_64-linux";
    #   gcc.arch = "znver3";
    #   gcc.tune = "znver3";
    # };
  };
}
