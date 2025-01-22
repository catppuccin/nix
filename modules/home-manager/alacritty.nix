{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.alacritty;
in

{
  options.catppuccin.alacritty = catppuccinLib.mkCatppuccinOption { name = "alacritty"; };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "programs"
      "alacritty"
      "catppuccin"
    ];
    to = "alacritty";
  };

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      settings.general.import = lib.mkBefore [ "${sources.alacritty}/catppuccin-${cfg.flavor}.toml" ];
    };
  };
}
