{lib, ...}: {
  den.aspects.impermanence = {
    nixos = {persist, ...}: {
      environment.persistence."/persist" = {
        enable = true;
        hideMounts = true;

        directories =
          [
            "/var/log"
            "/var/lib/nixos"
            "/var/lib/systemd/coredump"
            "/var/db/sudo"
            # "/var/lib/cups"
            # "/var/lib/greetd"
            # "/var/lib/regreet"

            "/etc/ssl/certs"
            "/etc/NetworkManager/system-connections"
            "/etc/nixos"
            # "/etc/greetd"
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
      persist,
      config,
      ...
    }: let
      homeDir = config.home.homeDirectory;

      relativeHomePath = path:
        if lib.hasPrefix "~/" path
        then lib.removePrefix "~/" path
        else if lib.hasPrefix "${homeDir}/" path
        then lib.removePrefix "${homeDir}/" path
        else path;

      processXDGPath = name: let
        xdgPath = config.xdg.${name + "Home"};
      in
        relativeHomePath xdgPath;

      mkXDGList = name:
        lib.genAttrs ["directories" "files"] (fnType:
          lib.concatMap (entry:
            map (itemPath: "${processXDGPath name}/${relativeHomePath itemPath}")
            entry.home.${name}.${fnType} or [])
          persist);

      # Based on HM XDG options
      # Used: persist.home.${name}.${type} = [];
      configHome = mkXDGList "config";
      dataHome = mkXDGList "data";
      stateHome = mkXDGList "state";
    in {
      home.persistence."/persist" = {
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
          ++ lib.concatMap (f: f.directories or []) [configHome dataHome stateHome];

        files =
          lib.concatMap (f: f.home.files or []) persist
          ++ lib.concatMap (f: f.files or []) [configHome dataHome stateHome];
      };
    };
  };

  den.quirks.persist = {
    description = "Directories and files to persist when impermanence is active";
  };
}
