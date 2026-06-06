{ catppuccinLib }:
{
  config,
  pkgs,
  lib,
  ...
}:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.fzf;
  enable = config.catppuccin.enable && cfg.enable && config.programs.fzf.enable;
in

{
  imports = [
    (lib.mkRemovedOptionModule [ "catppuccin" "fzf" "accent" ] ''
      in order to remove IFD from the fzf port we have started to use the
      FZF_DEFAULT_OPTS_FILE env var. and the upstream catppuccin port does not
      currently support accents.

      if you wish to keep using a accent consider using `programs.fzf.colors`
      to set the colors yourself.
    '')
  ];

  options.catppuccin.fzf = catppuccinLib.mkCatppuccinOption { name = "fzf"; };

  config = lib.mkIf enable {
    home.sessionVariables = {
      FZF_DEFAULT_OPTS_FILE = "${sources.fzf}/catppuccin-fzf-${cfg.flavor}.rc";
    };
  };
}
