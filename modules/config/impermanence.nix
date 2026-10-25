{
  inputs,
  lib,
  ...
}: {
  den.aspects.impermanence = {
    settings.persistDevice = lib.mkOption {
      type = lib.types.singleLineStr;
      default = "/persist";
      description = "Location of persistent device";
    };

    nixos = {
      host,
      persist,
      ...
    }: let
      cfg = host.settings.impermanence;
    in {
      imports = [inputs.impermanence.nixosModules.impermanence];

      environment.persistence.${cfg.persistDevice} = {
        enable = true;
        hideMounts = true;

        directories =
          [
            "/var/log"
            "/var/lib/nixos"
            "/var/lib/systemd/coredump"
            "/var/db/sudo"

            "/etc/ssl/certs"
            "/etc/NetworkManager/system-connections"
            "/etc/nixos"
          ]
          ++ lib.concatMap (f: f.directories or []) persist;

        files =
          [
            "/etc/machine-id"
            "/etc/NIXOS" # Empty file marker
          ]
          ++ lib.concatMap (f: f.files or []) persist;
      };
    };

    homeManager = {
      host,
      persist,
      config,
      ...
    }: let
      cfg = host.settings.impermanence;

      # Strip absolute path /home/<user>/
      processXDGPath = name: let
        homeDir = config.home.homeDirectory;
        xdgPath = config.xdg.${name + "Home"};
      in
        lib.strings.removePrefix "${homeDir}/" xdgPath;

      mkXDGList = name:
        lib.genAttrs ["directories" "files"] (fnType:
          lib.concatMap (entry:
            map (itemPath: "${processXDGPath name}/${itemPath}")
            entry.home.${name}.${fnType} or [])
          persist);

      # Based on HM XDG options
      # Used: persist.home.${name}.${type} = [];
      xdgHomesList = lib.map (s: mkXDGList s) ["config" "data" "state" "cache"];
    in {
      home.persistence.${cfg.persistDevice} = {
        directories =
          [
            "nixos"

            # Local
            ".local/share/applications"
            ".local/share/Trash"

            # Config
            ".config/nix"
          ]
          ++ lib.concatMap (f: f.home.directories or []) persist
          ++ lib.concatMap (f: f.directories or []) xdgHomesList;

        files =
          lib.concatMap (f: f.home.files or []) persist
          ++ lib.concatMap (f: f.files or []) xdgHomesList;
      };
    };
  };

  den.quirks.persist = {
    description = "Directories and files to persist when impermanence is active";
  };
}
