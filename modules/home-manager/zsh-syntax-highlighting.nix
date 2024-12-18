# In this file we define both `catppuccin.zsh-syntax-highlighting` and `programs.zsh.syntaxHighlighting.catppuccin` options this is beacuse
# we have to recreate the lib.mkRenamedOptionModule here due to the use of a submodule being used for `programs.zsh.syntaxHighlighting`
# which would lead to an error if we used the original `lib.mkRenamedOptionModule`.
#  see <https://github.com/catppuccin/nix/pull/371#discussion_r1835785145>
{ catppuccinLib }:
{ config, lib, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.zsh-syntax-highlighting;
  enable = cfg.enable && config.programs.zsh.syntaxHighlighting.enable;
  oldCfg = config.programs.zsh.syntaxHighlighting.catppuccin;
in

{
  options = {
    catppuccin.zsh-syntax-highlighting = catppuccinLib.mkCatppuccinOption {
      name = "Zsh Syntax Highlighting";
      default = config.catppuccin.enable || oldCfg.enable;
    };

    programs.zsh.syntaxHighlighting = lib.mkOption {
      type = lib.types.submodule {
        options.catppuccin =
          lib.recursiveUpdate
            (catppuccinLib.mkCatppuccinOption {
              name = "Zsh Syntax Highlighting";
              useGlobalEnable = false;
            })
            {
              # hide the options from the search
              enable.internal = true;
              flavor.internal = true;
            };
      };
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
