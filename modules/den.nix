{
  den,
  dev-tools,
  hardware,
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
      {
        nixpkgs-overlays = _: [
          inputs.nuenv.overlays.default
          inputs.nix-cachyos-kernel.overlays.pinned
        ];
      }
      boot.grub
      security.keyring
      security.polkit
      security.gnupg
      pkgs.cli-tools
      pkgs.shells
      pkgs.terminals
      pkgs.yazi
      pkgs.helix
      pkgs.fonts
      pkgs.fastfetch
      pkgs.git
      pkgs.bat
    ]
    ++ [
      den.batteries.inputs'
      den.batteries.self'
      dev-tools.nix
      dev-tools.utils
      hardware.default
    ];

  den.default.homeManager = {
    home.stateVersion = "26.05";
  };

  den.default.nixos = {pkgs, ...}: {
    imports = [
      inputs.nur.modules.nixos.default
    ];

    programs.appimage = {
      enable = true;
      binfmt = true;
    };

    specialisation.stable.configuration = {
      system.nixos.tags = ["stable"];
      boot.kernelPackages = lib.mkForce pkgs.linuxPackages;
    };

    home-manager.backupFileExtension = "hm-backup";

    programs.nix-ld = {
      enable = true;
    };

    environment.systemPackages = with pkgs; [
      btop
      vim
      wget
      firefox
      appimage-run
    ];

    # Enable the X11 windowing system.
    services.xserver.enable = lib.mkDefault true;
    services.xserver.videoDrivers = lib.mkDefault ["nvidia" "amdgpu" "modesetting" "fbdev"];
    programs.xwayland.enable = lib.mkDefault true;

    # Enable touchpad support (enabled default in most desktopManager).
    services.libinput.enable = lib.mkDefault true;

    services.dbus.implementation = lib.mkDefault "broker";

    services.kmscon.enable = lib.mkDefault true;

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
  };
}
