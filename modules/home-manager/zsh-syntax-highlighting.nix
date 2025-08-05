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

  config = lib.mkIf cfg.enable {
    programs.zsh =
      let
        key = if options.programs.zsh ? initContent then "initContent" else "initExtra";
      in
      {
        # NOTE: Backwards compatible mkOrder priority working with stable/unstable HM.
        "${key}" = lib.mkOrder (if key == "initContent" then 950 else 500) ''
          source '${sources.zsh-syntax-highlighting}/catppuccin_${cfg.flavor}-zsh-syntax-highlighting.zsh'
        '';
      };
  };
}
