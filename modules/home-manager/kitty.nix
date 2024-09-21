{ config, lib, ... }:
let
  inherit (lib) ctp;
  cfg = config.programs.kitty.catppuccin;
  enable = cfg.enable && config.programs.kitty.enable;

  # TODO: Remove after 24.11 is stable
  # https://github.com/nix-community/home-manager/pull/5750
  attrName = if (lib.versionAtLeast ctp.getModuleRelease "24.11") then "themeFile" else "theme";
in
{
  options.programs.kitty.catppuccin = ctp.mkCatppuccinOpt { name = "kitty"; };

  config = lib.mkIf enable { programs.kitty.${attrName} = "Catppuccin-${ctp.mkUpper cfg.flavor}"; };
}
