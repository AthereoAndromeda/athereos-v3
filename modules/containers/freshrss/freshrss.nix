{den, ...}: {
  den.aspects.containers.freshrss = {
    includes = [den.aspects.containers];
    persist.directories = ["/var/lib/nixos-containers/freshrss"];

    nixos = {config, ...}: let
      password-string = "freshrss/admin/password";
      password-path = config.sops.secrets.${password-string}.path;
    in {
      sops.secrets.${password-string} = {
        mode = "0744";
      };

      containers.freshrss = rec {
        autoStart = true;
        bindMounts.${password-path}.isReadOnly = true;
        privateNetwork = true;
        hostAddress = "192.168.100.10";
        localAddress = "192.168.100.12";
        hostAddress6 = "fc00::1";
        localAddress6 = "fc00::3";

        config = {lib, ...}: {
          services.freshrss = {
            enable = true;
            virtualHost = localAddress;
            passwordFile = password-path;
            baseUrl = "http://${localAddress}";
          };

          networking = {
            firewall.allowedTCPPorts = [80 443];

            # Use systemd-resolved inside the container
            # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
            useHostResolvConf = lib.mkForce false;
          };

          services.resolved.enable = true;
          system.stateVersion = "26.05";
        };
      };
    };
  };
}
