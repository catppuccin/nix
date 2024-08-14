{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) ctp;
  inherit (config.catppuccin) sources;
  inherit (pkgs.stdenv.hostPlatform) isDarwin;

  cfg = config.programs.lazygit.catppuccin;
  enable = cfg.enable && config.programs.lazygit.enable;
  configDirectory =
    if (isDarwin && !config.xdg.enable)
    then "${config.home.homeDirectory}/Library/Application Support/lazygit"
    else "${config.xdg.configHome}/lazygit";
in {
  options.programs.lazygit.catppuccin =
    lib.ctp.mkCatppuccinOpt {name = "lazygit";}
    // {
      accent = ctp.mkAccentOpt "lazygit";
    };

  config.home.sessionVariables = lib.mkIf enable {
    # Ensure that the default config file is still sourced
    LG_CONFIG_FILE = "${sources.lazygit}/themes-mergable/${cfg.flavor}/${cfg.accent}.yml,${configDirectory}/config.yml";
  };
}
