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

    homeManager = {pkgs, ...}: {
      services.espanso = {
        enable = true;
        configs = {
          default = {
            undo_backspace = true;
          };
        };
      };

      services.cliphist.enable = true;
      home.packages = with pkgs; [
        chromium
        super-productivity

        motrix
        motrix-next
      ];

      dconf.settings = {
        "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      };

      programs.carapace = {
        enable = true;
        enableBashIntegration = true;
        enableNushellIntegration = true;
      };
    };

    nixos = {pkgs, ...}: {
      programs.obs-studio = {
        enable = true;
        enableVirtualCamera = true;
      };

      # Set your time zone.
      time.timeZone = "Asia/Manila";

      # Prevent dual boot Windows breaking the time
      time.hardwareClockInLocalTime = true;

      # Configure network proxy if necessary
      # networking.proxy.default = "http://user:password@proxy:port/";
      # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

      # Select internationalisation properties.
      # i18n.defaultLocale = "en_US.UTF-8";
      # console = {
      #   font = "Lat2-Terminus16";
      #   keyMap = "us";
      #   useXkbConfig = true; # use xkb.options in tty.
      # };

      # Enable the X11 windowing system.
      # services.xserver.enable = true;

      # Configure keymap in X11
      # services.xserver.xkb.layout = "us";
      # services.xserver.xkb.options = "eurosign:e,caps:escape";

      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      };

      users.groups = {plugdev.gid = 601;}; # System Group
      users.mutableUsers = false;

      # List packages installed in system profile.
      # You can use https://search.nixos.org/ to find more packages (and options).
      environment.systemPackages = with pkgs; [
        vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        wget
        firefox
        nautilus

        # Tablet
        wvkbd
        lisgd
      ];

      services.xserver.wacom.enable = true;
      hardware.opentabletdriver.enable = true;

      nix.settings.trusted-users = ["athereo"];

      # Some programs need SUID wrappers, can be configured further or are
      # started in user sessions.
      # programs.mtr.enable = true;
      # programs.gnupg.agent = {
      #   enable = true;
      #   enableSSHSupport = true;
      # };

      # List services that you want to enable:

      # Open ports in the firewall.
      # networking.firewall.allowedTCPPorts = [ ... ];
      # networking.firewall.allowedUDPPorts = [ ... ];
      # Or disable the firewall altogether.
      # networking.firewall.enable = false;

      # Copy the NixOS configuration file and link it from the resulting system
      # (/run/current-system/configuration.nix). This is useful in case you
      # accidentally delete configuration.nix.
      # system.copySystemConfiguration = true;
    };
  };
}
