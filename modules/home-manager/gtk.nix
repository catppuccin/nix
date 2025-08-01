{ catppuccinLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    concatStringsSep
    mkRenamedOptionModule
    mkRemovedOptionModule
    toList
    ;

  cfg = config.catppuccin.gtk;

  namespaceRenameModules =
    catppuccinLib.mkRenamedCatppuccinOptions {
      from = [
        "gtk"
        "catppuccin"
      ];
      to = "gtk";
      accentSupport = true;
    }
    ++ catppuccinLib.mkRenamedCatppuccinOptions {
      from = [
        "gtk"
        "catppuccin"
        "cursor"
      ];
      to = "cursors";
      accentSupport = true;
    }
    ++ [
      (mkRenamedOptionModule
        [
          "gtk"
          "catppuccin"
          "size"
        ]
        [
          "catppuccin"
          "gtk"
          "size"
        ]
      )

      (mkRenamedOptionModule
        [
          "gtk"
          "catppuccin"
          "tweaks"
        ]
        [
          "catppuccin"
          "gtk"
          "tweaks"
        ]
      )

      (mkRenamedOptionModule
        [
          "gtk"
          "catppuccin"
          "gnomeShellTheme"
        ]
        [
          "catppuccin"
          "gtk"
          "gnomeShellTheme"
        ]
      )

      (mkRenamedOptionModule
        [
          "gtk"
          "catppuccin"
          "icon"
        ]
        [
          "catppuccin"
          "gtk"
          "icon"
        ]
      )
    ];

  # Relative to `catppuccin.gtk`
  removedOptions = [
    "enable"
    "flavor"
    "accent"

    "gnomeShellTheme"
    "size"
    "tweaks"
  ];

  removedOptionModules = map (
    optionPath:

    let
      attrPath = [
        "catppuccin"
        "gtk"
      ]
      ++ toList optionPath;
      moduleName = concatStringsSep "." attrPath;
    in

    mkRemovedOptionModule attrPath ''
      `${moduleName}` was removed from catppuccin/nix, as the upstream port has been archived and began experiencing breakages.

      Please see https://github.com/catppuccin/gtk/issues/262
    ''
  ) removedOptions;
in

{
  imports = namespaceRenameModules ++ removedOptionModules;

  options.catppuccin.gtk = {
    icon = catppuccinLib.mkCatppuccinOption {
      name = "GTK modified Papirus icon theme";

      accentSupport = true;
    };
  };

  config = lib.mkIf cfg.icon.enable {
    gtk.iconTheme =
      let
        # use the light icon theme for latte
        polarity = if cfg.icon.flavor == "latte" then "Light" else "Dark";
      in
      {
        name = "Papirus-${polarity}";
        package = pkgs.catppuccin-papirus-folders.override { inherit (cfg.icon) accent flavor; };
      };
  };
}
