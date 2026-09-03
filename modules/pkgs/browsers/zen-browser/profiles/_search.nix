pkgs: {
  force = true;
  default = "ddg";

  engines = {
    # duckduckgo = {
    #   name = "DuckDuckGo";
    #   definedAliases = ["@ddg" "@duckduckgo"];
    #   icon = ""
    # };

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

    noogle = {
      name = "Noogle";
      definedAliases = ["@noogle"];
      urls = [
        {
          template = "https://noogle.dev/q/?term={searchTerms}";
          params = {
            name = "query";
            value = "searchTerms";
          };
        }
      ];
    };

    youtube = {
      name = "YouTube";
      definedAliases = ["@yt" "@youtube"];
      icon = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAABsUlEQVRYR+2XTStEURjHf+dMkjBKmSRqdhZI3qYsrG28rIR8BsXGwgewUEhjjYWsLIRkY2NDFiQrNoMFmYUyg4yac3Rm5p6F1Exe7pHmV6dbz+nc57nn/O9z/1fgGOE4f7GAP7QDmvFSOOwD2Q7pMMgQqEqQ5dkrVWQKlgJU8HPtyAQoDSggATIJ6jl3jUPgCtQJdO8IoimzIiNCTaQV0ptAOHen3+YaAoOC4zOhGSqDq0tQ9XbaH26gpVFoIqOQXvcn50fksNB0zoOetDFfEVGh6dgDen3Na5F7QtN1DqrZxvIRqob+HljZBmXE/i2MCLvuQNXaUD7CdRDbgtMLmJiDgxM79QXuzBEkgQobyodXgMfGPkwtQuzWhgpHJk0BpnEUzscCDKk3WFiHmWVIvthwIfxMAR73DzC9BKs7BevjnxTwzSNwLULnr6HzRuSyFYtd1x+jWdOKx0CtWVn6SsmIZ0guQDX4mpucITFJHViyGwgMZCyZ99RZU3o0CKoNpPGGNUAQVDlghmdKZc6kfoI1pWY8gnwCTGdKgI6DvgZ5Ck1bgtVXs6L4Z1TcAec78A5wdbaf7rcfcQAAAABJRU5ErkJggg==";
      urls = [
        {
          template = "https://www.youtube.com/results?search_query={searchTerms}";
          params = [
            {
              name = "query";
              value = "searchTerms";
            }
          ];
        }
      ];
    };
  };
}
