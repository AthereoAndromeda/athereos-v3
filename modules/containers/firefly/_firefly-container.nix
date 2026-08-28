key-path: rec {
  autoStart = true;
  bindMounts.${key-path}.isReadOnly = true;
  privateNetwork = true;
  hostAddress = "192.168.100.10";
  localAddress = "192.168.100.11";
  hostAddress6 = "fc00::1";
  localAddress6 = "fc00::2";
  config = {
    pkgs,
    lib,
    ...
  }: {
    users.groups.firefly = {};
    users.users.firefly = {
      isSystemUser = true;
      group = "firefly";
      home = "/var/lib/firefly";
      createHome = true;
    };

    systemd.services.firefly-iii-setup = {
      after = ["mysql.service"];
      requires = ["mysql.service"];
    };

    services.firefly-iii = {
      enable = true;
      enableNginx = true;
      virtualHost = localAddress;
      user = "firefly";

      settings =
        lib.fromTOML (builtins.readFile ./.env)
        // {
          APP_KEY_FILE = key-path;
        };
    };

    services.mysql = {
      enable = true;
      package = pkgs.mariadb;

      # Explicitly create database and user credentials with password
      initialScript = pkgs.writeText "mariadb-init.sql" ''
        CREATE DATABASE IF NOT EXISTS firefly;
        CREATE USER IF NOT EXISTS 'firefly'@'127.0.0.1' IDENTIFIED BY 'firefly';
        CREATE USER IF NOT EXISTS 'firefly'@'localhost' IDENTIFIED BY 'firefly';
        GRANT ALL PRIVILEGES ON firefly.* TO 'firefly'@'127.0.0.1';
        GRANT ALL PRIVILEGES ON firefly.* TO 'firefly'@'localhost';
        FLUSH PRIVILEGES;
      '';

      initialDatabases = [
        {name = "firefly";}
      ];

      ensureUsers = [
        {
          name = "firefly";
          ensurePermissions = {
            "database.*" = "ALL PRIVILEGES";
            "*.*" = "SELECT, LOCK TABLES";
          };
        }
      ];

      ensureDatabases = ["firefly"];
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
}
