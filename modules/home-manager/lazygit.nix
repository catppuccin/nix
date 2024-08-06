{ config, lib, ... }:
let
  inherit (lib) ctp;
  inherit (config.catppuccin) sources;
  cfg = config.programs.lazygit.catppuccin;
  enable = cfg.enable && config.programs.lazygit.enable;
in
{
  options.programs.lazygit.catppuccin = lib.ctp.mkCatppuccinOpt { name = "lazygit"; } // {
    accent = ctp.mkAccentOpt "lazygit";
  };

  config.home.sessionVariables = lib.mkIf enable {
    # Ensure that the default config file is still sourced
    LG_CONFIG_FILE = "${sources.lazygit}/themes-mergable/${cfg.flavor}/${cfg.accent}.yml,${config.xdg.configHome}/lazygit/config.yml";
  };
}
