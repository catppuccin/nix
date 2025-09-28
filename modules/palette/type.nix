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
      rosewater = mkOptionReadOnly { type = colorFormat; };
      flamingo = mkOptionReadOnly { type = colorFormat; };
      pink = mkOptionReadOnly { type = colorFormat; };
      mauve = mkOptionReadOnly { type = colorFormat; };
      red = mkOptionReadOnly { type = colorFormat; };
      maroon = mkOptionReadOnly { type = colorFormat; };
      peach = mkOptionReadOnly { type = colorFormat; };
      yellow = mkOptionReadOnly { type = colorFormat; };
      green = mkOptionReadOnly { type = colorFormat; };
      teal = mkOptionReadOnly { type = colorFormat; };
      sky = mkOptionReadOnly { type = colorFormat; };
      sapphire = mkOptionReadOnly { type = colorFormat; };
      blue = mkOptionReadOnly { type = colorFormat; };
      lavender = mkOptionReadOnly { type = colorFormat; };
      text = mkOptionReadOnly { type = colorFormat; };
      subtext1 = mkOptionReadOnly { type = colorFormat; };
      subtext0 = mkOptionReadOnly { type = colorFormat; };
      overlay2 = mkOptionReadOnly { type = colorFormat; };
      overlay1 = mkOptionReadOnly { type = colorFormat; };
      overlay0 = mkOptionReadOnly { type = colorFormat; };
      surface2 = mkOptionReadOnly { type = colorFormat; };
      surface1 = mkOptionReadOnly { type = colorFormat; };
      surface0 = mkOptionReadOnly { type = colorFormat; };
      base = mkOptionReadOnly { type = colorFormat; };
      mantle = mkOptionReadOnly { type = colorFormat; };
      crust = mkOptionReadOnly { type = colorFormat; };
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
      black = mkOptionReadOnly { type = ansiColorGroup; };
      red = mkOptionReadOnly { type = ansiColorGroup; };
      green = mkOptionReadOnly { type = ansiColorGroup; };
      yellow = mkOptionReadOnly { type = ansiColorGroup; };
      blue = mkOptionReadOnly { type = ansiColorGroup; };
      magenta = mkOptionReadOnly { type = ansiColorGroup; };
      cyan = mkOptionReadOnly { type = ansiColorGroup; };
      white = mkOptionReadOnly { type = ansiColorGroup; };
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
