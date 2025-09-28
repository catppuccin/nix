lib:
let
  inherit (lib) types mkOption;

  mkOptionReadOnly = attrs: mkOption (attrs // { readOnly = true; });

  rgb = types.submodule {
    options = {
      r = mkOptionReadOnly {
        type = types.ints.u8;
        description = "Red, 0-255";
      };
      g = mkOptionReadOnly {
        type = types.ints.u8;
        description = "Green, 0-255";
      };
      b = mkOptionReadOnly {
        type = types.ints.u8;
        description = "Blue, 0-255";
      };
    };
  };

  hsl = types.submodule {
    options = {
      h = mkOptionReadOnly {
        type = types.float;
        description = "Hue, 0-360";
      };
      s = mkOptionReadOnly {
        type = types.float;
        description = "Saturation, 0-100";
      };
      l = mkOptionReadOnly {
        type = types.float;
        description = "Lightness, 0-100";
      };
    };
  };

  colorFormat = types.submodule {
    options = {
      name = mkOptionReadOnly {
        type = types.str;
        description = "Name of the color.";
      };
      order = mkOptionReadOnly {
        type = types.ints.unsigned;
        description = "Order of the color in the palette spec.";
      };
      hex = mkOptionReadOnly {
        type = types.str;
        description = "String-formatted hex value.";
        example = "#babbf1";
      };
      rgb = mkOptionReadOnly {
        type = rgb;
        description = "Formatted rgb value.";
        example = {
          r = 186;
          g = 187;
          b = 241;
        };
      };
      hsl = mkOptionReadOnly {
        type = hsl;
        description = "Formatted hsl value.";
        example = {
          h = 238.9;
          s = 12.1;
          l = 83.5;
        };
      };
      accent = mkOptionReadOnly {
        type = types.bool;
        description = "Indicates whether the color is intended to be used as an accent color.";
      };
    };
  };

  colors = types.submodule {
    options = {
      rosewater = mkOptionReadOnly {
        type = colorFormat;
        description = "Rosewater";
      };
      flamingo = mkOptionReadOnly {
        type = colorFormat;
        description = "Flamingo";
      };
      pink = mkOptionReadOnly {
        type = colorFormat;
        description = "Pink";
      };
      mauve = mkOptionReadOnly {
        type = colorFormat;
        description = "Mauve";
      };
      red = mkOptionReadOnly {
        type = colorFormat;
        description = "Red";
      };
      maroon = mkOptionReadOnly {
        type = colorFormat;
        description = "Maroon";
      };
      peach = mkOptionReadOnly {
        type = colorFormat;
        description = "Peach";
      };
      yellow = mkOptionReadOnly {
        type = colorFormat;
        description = "Yellow";
      };
      green = mkOptionReadOnly {
        type = colorFormat;
        description = "Green";
      };
      teal = mkOptionReadOnly {
        type = colorFormat;
        description = "Teal";
      };
      sky = mkOptionReadOnly {
        type = colorFormat;
        description = "Sky";
      };
      sapphire = mkOptionReadOnly {
        type = colorFormat;
        description = "Sapphire";
      };
      blue = mkOptionReadOnly {
        type = colorFormat;
        description = "Blue";
      };
      lavender = mkOptionReadOnly {
        type = colorFormat;
        description = "Lavender";
      };
      text = mkOptionReadOnly {
        type = colorFormat;
        description = "Text";
      };
      subtext1 = mkOptionReadOnly {
        type = colorFormat;
        description = "Subtext 1";
      };
      subtext0 = mkOptionReadOnly {
        type = colorFormat;
        description = "Subtext 0";
      };
      overlay2 = mkOptionReadOnly {
        type = colorFormat;
        description = "Overlay 2";
      };
      overlay1 = mkOptionReadOnly {
        type = colorFormat;
        description = "Overlay 1";
      };
      overlay0 = mkOptionReadOnly {
        type = colorFormat;
        description = "Overlay 0";
      };
      surface2 = mkOptionReadOnly {
        type = colorFormat;
        description = "Surface 2";
      };
      surface1 = mkOptionReadOnly {
        type = colorFormat;
        description = "Surface 1";
      };
      surface0 = mkOptionReadOnly {
        type = colorFormat;
        description = "Surface 0";
      };
      base = mkOptionReadOnly {
        type = colorFormat;
        description = "Base";
      };
      mantle = mkOptionReadOnly {
        type = colorFormat;
        description = "Mantle";
      };
      crust = mkOptionReadOnly {
        type = colorFormat;
        description = "Crust";
      };
    };
  };

  ansiColorFormat = types.submodule {
    name = mkOptionReadOnly {
      type = types.str;
      description = "Name of the ANSI group.";
    };
    hex = mkOptionReadOnly {
      type = types.str;
      description = "String-formatted hex value.";
      example = "#babbf1";
    };
    rgb = mkOptionReadOnly {
      type = rgb;
      description = "Formatted rgb value.";
      example = {
        r = 186;
        g = 187;
        b = 241;
      };
    };
    hsl = mkOptionReadOnly {
      type = hsl;
      description = "Formatted hsl value.";
      example = {
        h = 238.9;
        s = 12.1;
        l = 83.5;
      };
    };
    code = mkOptionReadOnly {
      type = types.ints.unsigned;
      description = "The ANSI color code.";
      example = 4;
    };
  };

  ansiColorGroup = types.submodule {
    name = mkOptionReadOnly {
      type = types.str;
      description = "Name of the ANSI color.";
    };
    order = mkOptionReadOnly {
      type = types.ints.unsigned;
      description = "Order of the ANSI color in the palette spec.";
    };
    normal = mkOptionReadOnly {
      type = ansiColorFormat;
      description = "An object containing all the ANSI \"normal\" colors, which are the 8 standard colors from 0 to 7.";
    };
    bright = mkOptionReadOnly {
      type = ansiColorFormat;
      description = ''
        An object containing all the ANSI "bright" colors, which are the 8 standard colors from 8 to 15.

        Note: These bright colors are not necessarily "brighter" than the normal colors, but rather more bold and saturated.
      '';
    };
  };

  ansiColors = types.submodule {
    options = {
      black = mkOptionReadOnly {
        type = ansiColorGroup;
        description = "Black";
      };
      red = mkOptionReadOnly {
        type = ansiColorGroup;
        description = "Red";
      };
      green = mkOptionReadOnly {
        type = ansiColorGroup;
        description = "Green";
      };
      yellow = mkOptionReadOnly {
        type = ansiColorGroup;
        description = "Yellow";
      };
      blue = mkOptionReadOnly {
        type = ansiColorGroup;
        description = "Blue";
      };
      magenta = mkOptionReadOnly {
        type = ansiColorGroup;
        description = "Magenta";
      };
      cyan = mkOptionReadOnly {
        type = ansiColorGroup;
        description = "Cyan";
      };
      white = mkOptionReadOnly {
        type = ansiColorGroup;
        description = "White";
      };
    };
  };
in
types.submodule {
  options = {
    name = mkOptionReadOnly {
      type = types.str;
      description = "Name of the flavor.";
    };
    emoji = mkOptionReadOnly {
      type = types.str;
      description = "Emoji associated with the flavor. Requires Unicode 13.0 (2020) or later to render.";
    };
    order = mkOptionReadOnly {
      type = types.ints.unsigned;
      description = "Order of the flavor in the palette spec.";
    };
    dark = mkOptionReadOnly {
      type = types.bool;
      description = "Whether the flavor is a dark theme.";
    };
    colors = mkOptionReadOnly {
      type = colors;
      description = "An object containing all the colors of the flavor.";
    };
    ansiColors = mkOptionReadOnly {
      type = ansiColors;
      description = "An object containing all the ANSI color mappings of the flavor.";
    };
  };
}
