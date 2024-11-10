{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.alacritty;
  enable = cfg.enable && config.programs.alacritty.enable;
in
{
  options.catppuccin.alacritty = lib.ctp.mkCatppuccinOpt { name = "alacritty"; };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "alacritty"
      "catppuccin"
    ];
    to = "alacritty";
  };

  config = lib.mkIf enable {
    programs.alacritty.settings = lib.importTOML "${sources.alacritty}/catppuccin-${cfg.flavor}.toml";
  };
}
