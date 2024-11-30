# In this file we define both `catppuccin.zsh-syntax-highlighting` and `programs.zsh.syntaxHighlighting.catppuccin` options this is beacuse
# we have to recreate the lib.mkRenamedOptionModule here due to the use of a submodule being used for `programs.zsh.syntaxHighlighting`
# which would lead to an error if we used the original `lib.mkRenamedOptionModule`.
#  see <https://github.com/catppuccin/nix/pull/371#discussion_r1835785145>
{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  inherit (lib) ctp;
  cfg = config.catppuccin.zsh-syntax-highlighting;
  enable = cfg.enable && config.programs.zsh.syntaxHighlighting.enable;

  oldCfg = config.programs.zsh.syntaxHighlighting.catppuccin;
in
{
  options = {
    catppuccin.zsh-syntax-highlighting = ctp.mkCatppuccinOpt {
      name = "Zsh Syntax Highlighting";
      enableDefault = config.catppuccin.enable || oldCfg.enable;
    };

    programs.zsh.syntaxHighlighting.catppuccin = ctp.mkCatppuccinOpt {
      name = "Zsh Syntax Highlighting";
      enableDefault = false;
    };
  };

  config = lib.mkIf enable (
    lib.mkMerge [
      {
        programs.zsh.initExtra = lib.mkBefore ''
          source '${sources.zsh-syntax-highlighting}/themes/catppuccin_${cfg.flavor}-zsh-syntax-highlighting.zsh'
        '';

        catppuccin.zsh-syntax-highlighting.flavor = lib.mkDefault oldCfg.flavor;
      }

      (lib.mkIf oldCfg.enable {
        warnings = [
          "`programs.zsh.syntaxHighlighting.catppuccin.enable` is deprecated. Please use `catppuccin.zsh-syntax-highlighting.enable` instead."
        ];
      })
    ]
  );
}
