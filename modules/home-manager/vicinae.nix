{ catppuccinLib }:
{ config, lib, ... }:

let
  cfg = config.catppuccin.vicinae;
in

{
  options.catppuccin.vicinae = catppuccinLib.mkCatppuccinOption {
    name = "vicinae";
    accentSupport = true;
  };

  config = lib.mkIf cfg.enable {
    programs.vicinae = {
      settings = {
        theme = {
          name = "catppuccin-${cfg.flavor}";
          iconTheme = "Catppuccin ${lib.toSentenceCase cfg.flavor} ${lib.toSentenceCase cfg.accent}";
        };
      };
    };
  };
}
