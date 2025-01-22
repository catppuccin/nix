{ catppuccinLib }:
{ config, lib, ... }:

let
  inherit (config.catppuccin) sources;

  cfg = config.catppuccin.swaylock;
in

{
  options.catppuccin.swaylock = catppuccinLib.mkCatppuccinOption {
    name = "swaylock";
    /*
      global `catppuccin.enable` purposefully doesn't work here in configurations with a `home.stateVersion`
      that is >= 23.05
      this is because the upstream module will automatically enable itself if `programs.swaylock.settings`
      is set in configurations with a `home.stateVersion` that is < 23.05. so, we can't use the
      `programs.swaylock.enable` option to guard against defining this like we usually do, as when the
      upstream `enable` option is unset on these systems it checks that same `settings` option we would be
      defining if *our* and the upstream's `enable` option is `true` ...leading to a case of infinite
      recursion where `programs.swaylock.settings` is only being defined if `programs.swaylock.settings` is
      defined
      debugging this was the most confusing and horrifying thing i've had to deal with throughout working on
      this project.
      - @getchoo
    */
    default = lib.versionAtLeast config.home.stateVersion "23.05" && config.catppuccin.enable;
    defaultText = lib.literalExpression ''
      `catppuccin.enable` if `home.stateVersion` is >= 23.05, false otherwise
      Yes this is weird, and there's a funny story about it in the code comments
    '';
  };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "programs"
      "swaylock"
      "catppuccin"
    ];
    to = "swaylock";
  };

  config = lib.mkIf cfg.enable {
    programs.swaylock = {
      settings = catppuccinLib.importINI (sources.swaylock + "/${cfg.flavor}.conf");
    };
  };
}
