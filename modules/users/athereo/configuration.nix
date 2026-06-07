{den, ...}: {
  den.aspects.athereo = {
    includes =
      (with den.batteries; [
        define-user
        primary-user
      ])
      ++ (with den.aspects; [
        impermanence
        hardware.athereo-nixos-ideapad
        grub
        xremap
        xdg-utils
        de.niri
        udev.probe-rs
        pkgs.zen-browser
        pkgs.localsend
        pkgs.just
        pkgs.yazi
        pkgs.shells
        pkgs.socials
        pkgs.zoxide
        pkgs.direnv
      ]);

    homeManager = {pkgs, ...}: {
      services.cliphist.enable = true;
      home.packages = with pkgs; [chromium];
    };

    nixos = {pkgs, ...}: {
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

      users.groups = {plugdev.gid = 601;}; # System Group

      users.mutableUsers = false;
      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users.athereo = {
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

      # List packages installed in system profile.
      # You can use https://search.nixos.org/ to find more packages (and options).
      environment.systemPackages = with pkgs; [
        git
        vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        helix
        wget
        firefox
      ];

      # Some programs need SUID wrappers, can be configured further or are
      # started in user sessions.
      # programs.mtr.enable = true;
      # programs.gnupg.agent = {
      #   enable = true;
      #   enableSSHSupport = true;
      # };

      # List services that you want to enable:

      # Enable the OpenSSH daemon.
      # services.openssh.enable = true;

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
