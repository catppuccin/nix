{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.oh-my-posh;
  palette = (lib.importJSON "${sources.palette}/palette.json").${cfg.flavor}.colors;
in

{
  options.catppuccin.oh-my-posh = catppuccinLib.mkCatppuccinOption { name = "oh-my-posh"; };

  config = lib.mkIf cfg.enable {
    programs.oh-my-posh = {
      settings.palette = lib.mapAttrs (colorName: colorInfo: colorInfo.hex) palette;
    };
  };
}
