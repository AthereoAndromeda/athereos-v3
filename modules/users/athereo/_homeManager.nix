{
  lib,
  pkgs,
  ...
}: {
  config = {
    # home.packages = with pkgs; [ ];

    gitEmail = "athereoandromeda@gmail.com";
    gitName = "Athereo";

    dconf.settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };
  };

  options = {
    gitEmail = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      description = "Email address to use for Git";
      default = null;
    };

    gitName = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      description = "Name to use for Git";
      default = null;
    };
  };
}
