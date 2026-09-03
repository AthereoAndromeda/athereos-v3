lib: let
  mapFn = i: v: {
    name = v.name;
    value = v.value // {position = i * 1000;};
  };
in
  builtins.listToAttrs (
    lib.imap1 mapFn [
      {
        name = "Home";
        value = {
          id = "6355d787-af5b-4be7-80ad-002f5a021768";
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
      }

      {
        name = "Socials";
        value = {
          id = "862a0ee5-bdce-4a42-ba57-a9cedcaeeb0c";
          icon = "💬";
          theme = {
            type = "gradient";
            opacity = 0.5;
            texture = 0.0;
            colors = [
              {
                red = 5;
                green = 138;
                blue = 60;
                algorithm = "analogous";
                lightness = 27;
                position.x = 136;
                position.y = 211;
              }
              {
                red = 59;
                green = 133;
                blue = 5;
                algorithm = "analogous";
                lightness = 27;
                position.x = 176;
                position.y = 233;
              }
            ];
          };
        };
      }

      {
        name = "Academic Oval";
        value = {
          id = "bb2fabeb-400d-40eb-ad29-b98118a7f4b6";
          icon = "🎓";
          theme = {
            type = "gradient";
            opacity = 0.423;
            texture = 0.1875;
            colors = [
              {
                red = 101;
                green = 101;
                blue = 205;
                algorithm = "analogous";
                lightness = 60;
                position.x = 133;
                position.y = 98;
              }
              {
                red = 100;
                green = 186;
                blue = 206;
                algorithm = "analogous";
                lightness = 60;
                position.x = 87;
                position.y = 162;
              }
            ];
          };
        };
      }

      {
        name = "Development";
        value = {
          id = "0e573cf9-38bc-432c-a465-a9002afb6e30";
          icon = "chrome://browser/skin/zen-icons/selectable/code.svg";
          theme = {
            type = "gradient";
            opacity = 0.33;
            texture = 0.375;
            colors = [
              {
                red = 234;
                green = 123;
                blue = 137;
                algorithm = "floating";
                lightness = 70;
                position.x = 234;
                position.y = 173;
              }
            ];
          };
        };
      }

      {
        name = "Music";
        value = {
          id = "dd6db8df-c9ae-4535-9c44-55d83382ec7e";
          icon = "🎵";
          theme = {
            type = "gradient";
            opacity = 0.423;
            texture = 0.25;
            colors = [
              {
                red = 250;
                green = 88;
                blue = 26;
                algorithm = "floating";
                lightness = 54;
                position.x = 280;
                position.y = 210;
              }
            ];
          };
        };
      }

      {
        name = "Official";
        value = {
          id = "988e43f6-195d-43ea-8902-107880c8d02d";
          icon = "🏛️";
        };
      }

      {
        name = "Gaming";
        value = {
          id = "41a54167-2467-490f-a2e5-0d14b56f6efc";
          icon = "🎮";
          theme = {
            type = "gradient";
            opacity = 0.44;
            texture = 0.0;
            colors = [
              {
                red = 70;
                green = 236;
                blue = 168;
                algorithm = "analogous";
                lightness = 60;
                position.x = 147;
                position.y = 195;
              }
              {
                red = 70;
                green = 169;
                blue = 236;
                algorithm = "analogous";
                lightness = 60;
                position.x = 145;
                position.y = 165;
              }
              {
                red = 110;
                green = 237;
                blue = 69;
                algorithm = "analogous";
                lightness = 60;
                position.x = 171;
                position.y = 214;
              }
            ];
          };
        };
      }
    ]
  )
