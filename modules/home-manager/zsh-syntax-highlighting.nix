{ catppuccinLib }:
{
  options,
  config,
  lib,
  ...
}:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.zsh-syntax-highlighting;
in

{
  options = {
    catppuccin.zsh-syntax-highlighting = catppuccinLib.mkCatppuccinOption {
      name = "Zsh Syntax Highlighting";
    };
  };

  config = lib.mkIf (config.catppuccin._enable && cfg.enable) {
    programs.zsh.initContent = lib.mkOrder 950 ''
      source '${sources.zsh-syntax-highlighting}/catppuccin_${cfg.flavor}-zsh-syntax-highlighting.zsh'
    '';
  };
}
