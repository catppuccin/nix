{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;
  cfg = config.catppuccin.lazygit;
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

  config = lib.mkIf cfg.enable {
    # TODO: Find a way to "source" a config file with $LG_CONFIG_FILE
    # and *not* come across https://github.com/catppuccin/nix/issues/455
    # https://github.com/jesseduffield/lazygit/blob/4b4d82e13c568f3b43c018740132454446cb0a2e/docs/Config.md#overriding-default-config-file-location
    programs.lazygit.settings = catppuccinLib.importYAML (sources.lazygit + "/${cfg.flavor}/${cfg.accent}.yml");
  };
}
