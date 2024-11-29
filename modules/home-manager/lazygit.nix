{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) ctp;
  inherit (config.catppuccin) sources;

  cfg = config.programs.lazygit.catppuccin;
  enable = cfg.enable && config.programs.lazygit.enable;

  # NOTE: On MacOS specifically, k9s expects its configuration to be in
  # `~/Library/Application Support` when not using XDG
  enableXdgConfig = !pkgs.stdenv.hostPlatform.isDarwin || config.xdg.enable;

  configDirectory =
    if enableXdgConfig then
      config.xdg.configHome
    else
      "${config.home.homeDirectory}/Library/Application Support";
  configFile = "${configDirectory}/lazygit/config.yml";
in
{
  options.programs.lazygit.catppuccin = lib.ctp.mkCatppuccinOpt { name = "lazygit"; } // {
    accent = ctp.mkAccentOpt "lazygit";
  };

  config.home.sessionVariables = lib.mkIf enable {
    # Ensure that the default config file is still sourced
    LG_CONFIG_FILE = "${sources.lazygit}/${cfg.flavor}/${cfg.accent}.yml,${configFile}";
  };
}
