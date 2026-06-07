{lib, ...}: {
  den.aspects.desktop.wpaperd = {
    homeManager = {...}: {
      services.wpaperd = {
        enable = true;
        # settings = {
        #   default = {
        #     duration = "5m";
        #     mode = "center";
        #     sorting = "random";
        #     transition.stereo-viewer = {};
        #   };

        #   any.path = "/home/athereo/Pictures/Wallpapers";
        # };
        settings = lib.fromTOML ''
          [default]
          duration = "5m"
          mode = "center"
          sorting = "random"

          [default.transition.stereo-viewer]

          [any]
          path = "/home/athereo/Pictures/Wallpapers"
        '';
      };
    };
  };
}
