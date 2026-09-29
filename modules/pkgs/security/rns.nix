{den, ...}: {
  den.aspects.security.rns = {
    includes = [
      (den.batteries.unfree [
        ])
    ];

    persist.home.directories = [".reticulum" ".nomadnetwork"];
    persist.home.config.directories = ["sideband"];

    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [rns nomadnet];

      # AutoInterface Ports
      networking.firewall.allowedUDPPorts = [
        42671 # Data Traffic
        29716 # Peer Discovery
        # 4242
      ];
    };
  };
}
