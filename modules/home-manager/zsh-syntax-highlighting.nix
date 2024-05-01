{ config
, lib
, sources
, ...
}:
let
  inherit (lib) ctp;
  cfg = config.programs.zsh.syntaxHighlighting.catppuccin;
  enable = cfg.enable && config.programs.zsh.syntaxHighlighting.enable;
in
{
  options.programs.zsh.syntaxHighlighting.catppuccin =
    ctp.mkCatppuccinOpt "zsh syntax highlighting";

  config.programs.zsh = lib.mkIf enable {
    initExtra = lib.mkBefore ''
      source '${sources.zsh-syntax-highlighting}/themes/catppuccin_${cfg.flavour}-zsh-syntax-highlighting.zsh'
    '';
  };
}
