{ catppuccinLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.lazygit;
  enable = config.catppuccin._enable && cfg.enable && config.programs.lazygit.enable;

  # NOTE: On MacOS specifically, lazygit expects its configuration to be in
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
  options.catppuccin.lazygit = catppuccinLib.mkCatppuccinOption {
    name = "lazygit";
    accentSupport = true;
  };

  config = lib.mkIf enable {
    home.sessionVariables =
      let
        configFiles = [
          "${sources.lazygit}/${cfg.flavor}/${cfg.accent}.yml"
        ]
        ++ lib.optional (config.programs.lazygit.settings != { }) configFile;
      in
      {
        # Ensure that the default config file is still sourced
        LG_CONFIG_FILE = lib.concatStringsSep "," configFiles;
      };
  };
}
