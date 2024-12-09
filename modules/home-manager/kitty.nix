{ config, lib, ... }:
let
  inherit (lib) ctp;
  cfg = config.catppuccin.kitty;
  enable = cfg.enable && config.programs.kitty.enable;

  # TODO: Remove after 24.11 is stable
  # https://github.com/nix-community/home-manager/pull/5750
  attrName = if (lib.versionAtLeast ctp.getModuleRelease "24.11") then "themeFile" else "theme";
in
{
  options.catppuccin.kitty = ctp.mkCatppuccinOpt { name = "kitty"; };

  imports = lib.ctp.mkRenamedCatppuccinOpts {
    from = [
      "programs"
      "kitty"
      "catppuccin"
    ];
    to = "kitty";
  };

  config = lib.mkIf enable { programs.kitty.${attrName} = "Catppuccin-${ctp.mkUpper cfg.flavor}"; };
}
