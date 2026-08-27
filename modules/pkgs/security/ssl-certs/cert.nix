{...}: {
  den.aspects.security.cert = {
    nixos = {config, ...}: {
      sops.secrets."network-auth/dilnet/user" = {};
      sops.secrets."network-auth/dilnet/password" = {};
      sops.secrets."network-auth/eduroam/user" = {};
      sops.secrets."network-auth/eduroam/password" = {};

      sops.templates."DILNET2.0.nmconnection" = {
        path = "/etc/NetworkManager/system-connections/DILNET2.0.nmconnection";
        mode = "0600";

        content = ''
          [connection]
          id=DILNET2.0
          uuid=6bf6c360-d8dc-4c6b-a559-0e1a1cdd6354
          type=wifi
          interface-name=wlp2s0

          [wifi]
          mode=infrastructure
          ssid=DILNET2.0

          [wifi-security]
          key-mgmt=wpa-eap

          [ipv4]
          method=auto

          [ipv6]
          method=auto

          [802-1x]
          eap=ttls;
          phase2-auth=pap;
          anonymous-identity=@upd.edu.ph;
          ca-cert=${./upd_dilnet.crt}
          identity=${config.sops.placeholder."network-auth/dilnet/user"}
          password=${config.sops.placeholder."network-auth/dilnet/password"}
        '';
      };
      sops.templates."eduroam.nmconnection" = {
        path = "/etc/NetworkManager/system-connections/eduroam.nmconnection";
        mode = "0600";

        content = ''
          [connection]
          id=eduroam
          uuid=888574de-ac80-4a33-9e39-e113e1ee248f
          type=wifi
          interface-name=wlp2s0

          [wifi]
          mode=infrastructure
          ssid=eduroam

          [wifi-security]
          key-mgmt=wpa-eap

          [ipv4]
          method=auto

          [ipv6]
          method=auto

          [802-1x]
          eap=ttls;
          phase2-auth=pap;
          anonymous-identity=@upd.edu.ph;
          ca-cert=${./upd_eduroam.crt}
          identity=${config.sops.placeholder."network-auth/eduroam/user"}
          password=${config.sops.placeholder."network-auth/eduroam/password"}
        '';
      };

      #   networking.networkmanager.ensureProfiles.profiles = {
      #     "Dilnet" = {
      #       connection = {
      #         id = "dilnet";
      #         type = "wifi";
      #         interface-name = "wlp2s0"; # TODO: Get wireless interface programatically
      #       };
      #       wifi = {
      #         ssid = "DILNET2.0";
      #         mode = "infrastructure";
      #       };
      #       wifi-security = {
      #         key-mgmt = "wpa-eap";
      #       };
      #       ipv4 = {
      #         method = "auto";
      #       };
      #       ipv6 = {
      #         method = "auto";
      #       };

      #       "802-1x" = {
      #         eap = "ttls;";
      #         phase2-auth = "pap;";
      #         anonymous-identity = "@upd.edu.ph";
      #         ca-cert = toString ./upd_dilnet.crt;
      #         identity = "YOUR_USERNAME";
      #         password = "YOUR_PASSWORD"; # Alternatively, remove this line to be prompted
      #       };
      #     };
    };
  };
}
