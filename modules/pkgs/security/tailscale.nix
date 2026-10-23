{lib, ...}: {
  den.aspects.security.tailscale = {
    persist.home.config.directories = ["tailscale"];
    persist.directories = [
      {
        directory = "/var/lib/tailscale";
        mode = "0700";
      }
    ];

    nixos = {config, ...}: {
      services.tailscale = {
        enable = true;
        openFirewall = true;
      };

      networking.firewall = {
        # Always allow traffic from your Tailscale network
        trustedInterfaces = [config.services.tailscale.interfaceName];
        # Allow the Tailscale UDP port through the firewall
        allowedUDPPorts = [config.services.tailscale.port];
      };

      # 2. Force tailscaled to use nftables (Critical for clean nftables-only systems)
      # This avoids the "iptables-compat" translation layer issues.
      systemd.services.tailscaled.serviceConfig.Environment = lib.mkIf config.networking.nftables.enable [
        "TS_DEBUG_FIREWALL_MODE=nftables"
      ];

      # # 3. Optimization: Prevent systemd from waiting for network online
      # # (Optional but recommended for faster boot with VPNs)
      # systemd.network.wait-online.enable = false;
      # boot.initrd.systemd.network.wait-online.enable = false;
    };
  };
}
