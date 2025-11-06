{ catppuccinLib }:
{
  lib,
  config,
  ...
}:
let
  inherit (config.catppuccin) sources;

  valuesFromEnum =
    enum: if lib.isList enum.functor.payload then enum.functor.payload else enum.functor.payload.values;

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
in
{
  options.catppuccin = lib.genAttrs supportedForges (
    name:
    catppuccinLib.mkCatppuccinOption {
      inherit name;
      accentSupport = true;
    }
  );

  config = lib.mkMerge (
    map (
      forge:
      let
        cfg = config.catppuccin.${forge};

        inherit (config.services.${forge}) customDir;
        hasAssetsDir = lib.versionAtLeast config.services.${forge}.package.version "1.21.0";
        themeDir = if hasAssetsDir then "${customDir}/public/assets/css" else "${customDir}/public/css";
      in
      lib.mkIf (cfg.enable && config.services.${forge}.enable) {
        systemd.tmpfiles.settings."10-catppuccin-${forge}-theme" = {
          ${themeDir}."C+" = {
            argument = toString sources.gitea;
          };

          "${customDir}/public".d = {
            inherit (config.services.${forge}) user group;
          };

          "${customDir}/public/assets".d = lib.attrsets.optionalAttrs (hasAssetsDir) {
            inherit (config.services.${forge}) user group;
          };
        };

        services.${forge}.settings.ui = {
          DEFAULT_THEME = "catppuccin-${cfg.flavor}-${cfg.accent}";
          THEMES = lib.concatStringsSep "," (
            builtinThemes.${forge}
            ++ (lib.mapCartesianProduct ({ flavor, accent }: "catppuccin-${flavor}-${accent}") (
              lib.mapAttrs (lib.const valuesFromEnum) {
                inherit (catppuccinLib.types) accent flavor;
              }
            ))
          );
        };
      }
    ) supportedForges
  );
}
