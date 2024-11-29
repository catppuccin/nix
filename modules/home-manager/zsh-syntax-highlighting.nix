{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.zsh-syntax-highlighting;
  oldCfg = config.programs.zsh.syntaxHighlighting.catppuccin;

  isSubmoduleOptionDefined = value: (builtins.tryEval value).success;
in

{
  options = {
    catppuccin.zsh-syntax-highlighting = catppuccinLib.mkCatppuccinOption {
      name = "Zsh Syntax Highlighting";
    };

    # `mkRenamedOptionModule` can't rename submodule options to top-level ones
    # Enter this nonsense
    # TODO: Abstract this

    # Extend the base submodule with our own options
    programs.zsh.syntaxHighlighting = {
      # Create options manually as `mkRenamedOptionModule` would
      catppuccin = {
        # But don't include the `trace` to each option since we do need to
        # check them with `isSubmoduleOptionDefined`
        enable = lib.mkOption {
          type = lib.types.bool;
          description = "Alias of `catppuccin.zsh-syntax-highlighting.enable`";
          visible = false;
        };

        flavor = lib.mkOption {
          type = catppuccinLib.types.flavor;
          description = "Alias of `catppuccin.zsh-syntax-highlighting.flavor`";
          visible = false;
        };
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf (isSubmoduleOptionDefined oldCfg.enable) {
      # Place the warning, also like `mkRenamedOptionModule` normally would
      warnings = [
        "The option `programs.zsh.syntaxHighlighting.catppuccin.enable` has been renamed to `catppuccin.zsh-syntax-highlighting.enable`."
      ];

      # Actually alias the option
      catppuccin.zsh-syntax-highlighting.enable = oldCfg.enable;
    })

    # Do it again for the flavor
    (lib.mkIf (isSubmoduleOptionDefined oldCfg.flavor) {
      warnings = [
        "The option `programs.zsh.syntaxHighlighting.catppuccin.flavor` has been renamed to `catppuccin.zsh-syntax-highlighting.flavor`."
      ];

      catppuccin.zsh-syntax-highlighting.flavor = oldCfg.flavor;
    })

    # And this is our actual module
    (lib.mkIf cfg.enable {
      programs.zsh = {
        initExtra = lib.mkBefore ''
          source '${sources.zsh-syntax-highlighting}/catppuccin_${cfg.flavor}-zsh-syntax-highlighting.zsh'
        '';
      };
    })
  ];
}
