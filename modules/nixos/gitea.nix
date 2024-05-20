{ catppuccinLib }:
{
  lib,
  config,
  ...
}:
let
  inherit (config.catppuccin) sources;

  supportedForges = [
    "gitea"
    "forgejo"
  ];

  builtinThemes = {
    gitea = [
      "auto"
      "gitea"
      "arc-greeen"
    ];

    forgejo = [
      "forgejo-auto"
      "forgejo-light"
      "forgejo-dark"
      "gitea-auto"
      "gitea-light"
      "gitea-dark"
      "forgejo-auto-deuteranopia-protanopia"
      "forgejo-light-deuteranopia-protanopia"
      "forgejo-dark-deuteranopia-protanopia"
      "forgejo-auto-tritanopia"
      "forgejo-light-tritanopia"
      "forgejo-dark-tritanopia"
    ];
  };

  generateConfig =
    forge:
    let
      cfg = config.catppuccin.${forge};
    in
    lib.mkIf cfg.enable {
      systemd.services.${forge}.preStart =
        let
          inherit (config.services.${forge}) customDir;

          baseDir =
            if lib.versionAtLeast config.services.${forge}.package.version "1.21.0" then
              "${customDir}/public/assets"
            else
              "${customDir}/public";
        in
        lib.mkAfter ''
          rm -rf ${baseDir}/css
          mkdir -p ${baseDir}
          ln -sf ${sources.gitea} ${baseDir}/css
        '';

      services.${forge}.settings.ui = {
        DEFAULT_THEME = "catppuccin-${cfg.flavor}-${cfg.accent}";
        THEMES = builtins.concatStringsSep "," (
          builtinThemes.${forge}
          ++ (lib.mapCartesianProduct ({ flavors, accents }: "catppuccin-${flavors}-${accents}") {
            inherit (catppuccinLib.consts) flavors accents;
          })
        );
      };
    };
in
{
  options.catppuccin = lib.genAttrs supportedForges (
    name:
    catppuccinLib.mkCatppuccinOption {
      inherit name;
      accentSupport = true;
    }
  );

  config = lib.mkMerge (map generateConfig supportedForges);
}
