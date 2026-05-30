{ catppuccinLib }:
{ config, lib, ... }:

let
  cfg = config.catppuccin.vicinae;
in

{
  options.catppuccin.vicinae = catppuccinLib.mkCatppuccinOption {
    name = "vicinae";
    accentSupport = true;
    darkLightSupport = true;
  };

  config = lib.mkIf cfg.enable {
    programs.vicinae = {
      settings.theme = {
        light = {
          name = "catppuccin-${cfg.lightFlavor}";
          iconTheme = "Catppuccin ${lib.toSentenceCase cfg.lightFlavor} ${lib.toSentenceCase cfg.accent}";
        };
        dark = {
          name = "catppuccin-${cfg.darkFlavor}";
          iconTheme = "Catppuccin ${lib.toSentenceCase cfg.darkFlavor} ${lib.toSentenceCase cfg.accent}";
        };
      };
    };
  };
}
