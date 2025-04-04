{
  config,
  pkgs,
  ...
}: {
  neovide = {
    enable = true;

    settings = {
      vsync = true;

      box-drawing = {
        mode = "font-glyph";
      };

      font = {
        # "Symbols Nerd Font Mono"

        normal = {
          family = "MonoLisa";
          style = "Medium";
        };
        bold = {
          family = "MonoLisa";
          style = "Medium";
        };
        italic = {
          family = "MonoLisa";
          style = "Medium Italic";
        };
        bold_italic = {
          family = "MonoLisa";
          style = "Bold Italic";
        };

        size = 14.0;

        features = {
          "MonoLisa" = ["+zero" "+calt" "+liga" "+ss02" "+ss11"];
        };
      };
    };
  };
}
