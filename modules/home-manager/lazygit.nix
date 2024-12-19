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
  options.catppuccin.lazygit = catppuccinLib.mkCatppuccinOption {
    name = "lazygit";
    accentSupport = true;
  };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "programs"
      "lazygit"
      "catppuccin"
    ];
    to = "lazygit";
    accentSupport = true;
  };

  config = lib.mkIf enable {
    home.sessionVariables = {
      # Ensure that the default config file is still sourced
      LG_CONFIG_FILE = "${sources.lazygit}/${cfg.flavor}/${cfg.accent}.yml,${configFile}";
    };
  };
}
