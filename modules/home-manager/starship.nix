{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.starship;
in

{
  options.catppuccin.starship = catppuccinLib.mkCatppuccinOption { name = "starship"; };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "programs"
      "starship"
      "catppuccin"
    ];
    to = "starship";
  };

  config = lib.mkIf cfg.enable {
    programs.starship = {
      settings = {
        format = lib.mkDefault "$all";
        palette = "catppuccin_${cfg.flavor}";
      } // lib.importTOML "${sources.starship}/${cfg.flavor}.toml";
    };
  };
}
