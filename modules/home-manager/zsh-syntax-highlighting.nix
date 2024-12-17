{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  inherit (lib) ctp;
  cfg = config.programs.zsh.syntaxHighlighting.catppuccin;
  enable = cfg.enable && config.programs.zsh.syntaxHighlighting.enable;
in
{
  options.programs.zsh.syntaxHighlighting.catppuccin = ctp.mkCatppuccinOption {
    name = "Zsh Syntax Highlighting";
  };

  config.programs.zsh = lib.mkIf enable {
    initExtra = lib.mkBefore ''
      source '${sources.zsh-syntax-highlighting}/themes/catppuccin_${cfg.flavor}-zsh-syntax-highlighting.zsh'
    '';
  };
}
