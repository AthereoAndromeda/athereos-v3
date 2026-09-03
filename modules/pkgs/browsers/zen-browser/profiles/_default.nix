pkgs: {
  settings = {
    "browser.tabs.hoverPreview.enabled" = true;
    "zen.workspaces.continue-where-left-off" = true;
  };

  extensions = {
    packages = with pkgs.nur.repos.rycee.firefox-addons; [
      # Privacy
      ublock-origin
      privacy-badger
      facebook-container
      private-relay

      # Website enhancers
      enhancer-for-youtube
      return-youtube-dislikes
      refined-github

      # QoL
      simple-translate
      tab-stash
      web-scrobbler

      # Missing
      # soundfixer
      # Strict pop-up blocker
    ];
  };

  mods = [
    "2317fd93-c3ed-4f37-b55a-304c1816819e" # Audio Indicator Enhanced
    "72f8f48d-86b9-4487-acea-eb4977b18f21" # Better CtrlTab Panel
    "a6335949-4465-4b71-926c-4a52d34bc9c0" # Better Find Bar
    "f7c71d9a-bce2-420f-ae44-a64bd92975ab" # Better Unloaded Tabs
    "ea1a5ace-f698-4b45-ab88-6e8bd3a563f0" # Bookmark Toolbar Tweaks
    "3ff55ba7-4690-4f74-96a8-9e4416685e4e" # Colore Container Tab
    "5bb07b6e-c89f-4f4a-a0ed-e483cc535594" # Custom MenuButton
    "32aca67a-ffdd-49e7-95c7-1821793610ca" # Custom Statusbar
    "253a3a74-0cc4-47b7-8b82-996a64f030d5" # Floating History
    # "cfa711cf-e9f7-4c35-8289-3e7633f93565" # Fluid URL
    "ae7868dc-1fa1-469e-8b89-a5edf7ab1f24" # Load Bar
    "599a1599-e6ab-4749-ab22-de533860de2c" # Pimp your PiP
    "58649066-2b6f-4a5b-af6d-c3d21d16fc00" # Private Mode Highlighting
    "ad97bb70-0066-4e42-9b5f-173a5e42c6fc" # SuperPins
    "87196c08-8ca1-4848-b13b-7ea41ee830e7" # Tab Preview Enhanced
    "4c2bec61-7f6c-4e5c-bdc6-c9ad1aba1827" # Vertical Split Tab Groups
    "03a8e7ef-cf00-4f41-bf24-a90deeafc9db" # Zen Colored Picker
  ];

  spacesForce = true;
  spaces = {
    "Home" = {
      id = "6355d787-af5b-4be7-80ad-002f5a021768";
      position = 1000;
      icon = "🏠";
      theme = {
        type = "gradient";
        opacity = 0.7;
        texture = 0.25;
        colors = [
          {
            red = 121;
            green = 5;
            blue = 143;
            algorithm = "analogous";
            lightness = 30;
            position.x = 200;
            position.y = 127;
          }
          {
            red = 143;
            green = 5;
            blue = 49;
            algorithm = "analogous";
            lightness = 30;
            position.x = 232;
            position.y = 162;
          }
          {
            red = 9;
            green = 5;
            blue = 148;
            algorithm = "analogous";
            lightness = 30;
            position.x = 153;
            position.y = 129;
          }
        ];
      };
    };

    "Socials" = {
      id = "862a0ee5-bdce-4a42-ba57-a9cedcaeeb0c";
      position = 2000;
      icon = "💬";
    };

    "Academic Oval" = {
      id = "bb2fabeb-400d-40eb-ad29-b98118a7f4b6";
      position = 3000;
      icon = "🎓";
    };

    "Development" = {
      id = "0e573cf9-38bc-432c-a465-a9002afb6e30";
      position = 4000;
      icon = "chrome://browser/skin/zen-icons/selectable/code.svg";
    };

    "Music" = {
      id = "dd6db8df-c9ae-4535-9c44-55d83382ec7e";
      position = 5000;
      icon = "🎵";
    };

    "Official" = {
      id = "988e43f6-195d-43ea-8902-107880c8d02d";
      position = 6000;
      icon = "🏛️";
    };
  };

  containersForce = true;
  containers = {
    Personal = {
      color = "blue";
      icon = "fingerprint";
      id = 1;
    };

    Academic = {
      color = "purple";
      icon = "tree";
      id = 2;
    };

    Banking = {
      color = "green";
      icon = "dollar";
      id = 3;
    };

    Work = {
      color = "yellow";
      icon = "briefcase";
      id = 4;
    };

    Shopping = {
      color = "pink";
      icon = "cart";
      id = 5;
    };

    Facebook = {
      color = "toolbar";
      icon = "fence";
      id = 6;
    };
  };

  search = {
    default = "ddg";

    engines = {
      mynixos = {
        name = "MyNixOS";
        definedAliases = ["@nix"];
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        urls = [
          {
            template = "https://mynixos.com/search?q={searchTerms}";
            params = [
              {
                name = "query";
                value = "searchTerms";
              }
            ];
          }
        ];
      };

      youtube = {
        name = "YouTube";
        definedAliases = ["@yt"];
        urls = [
          {
            template = "https://www.youtube.com/results?search_query={search}";
            params = [
              {
                name = "query";
                value = "search";
              }
            ];
          }
        ];
      };
    };
  };
}
