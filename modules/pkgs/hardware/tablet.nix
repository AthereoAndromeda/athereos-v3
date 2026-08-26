{...}: {
  den.aspects.hardware.tablet = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        wvkbd
        # FIXME: Error with multitouch
        lisgd
        libinput
        libinput-gestures

        iio-niri
        iio-sensor-proxy

        rot8
        ruby
      ];

      services.xserver.wacom.enable = true;
      hardware.opentabletdriver.enable = true;
      hardware.sensor.iio.enable = true;
    };
  };
}
