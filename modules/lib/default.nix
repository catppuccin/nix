{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    flip
    importJSON
    mkEnableOption
    mkOption
    mkSinkUndeclaredOptions
    optionalAttrs
    types
    versionAtLeast
    toSentenceCase
    ;

  inherit (lib.modules) importApply;

  inherit (pkgs)
    runCommand
    ;
in

lib.makeExtensible (ctp: {
  types = {
    flavor = types.enum [
      "latte"
      "frappe"
      "macchiato"
      "mocha"
    ];

    accent = types.enum [
      "blue"
      "flamingo"
      "green"
      "lavender"
      "maroon"
      "mauve"
      "peach"
      "pink"
      "red"
      "rosewater"
      "sapphire"
      "sky"
      "teal"
      "yellow"
    ];
  };

  /**
    Capitalize the first letter in a string, and change the final "e" into "é" if the
    original string is "frappe"

    # Example

    ```nix
    mkFlavorName "frappe"
    => "Frappé"
    ```

    # Type

    ```
    mkFlavorName :: String -> String
    ```

    # Arguments

    - [str] String to capitalize
  */
  mkFlavorName = str: if str == "frappe" then "Frappé" else toSentenceCase str;

  /**
    Reads a YAML file

    # Example

    ```nix
    importYAML ./file.yaml
    ```

    # Type

    ```
    importYAML :: Path -> Any
    ```

    # Arguments

    - [path] Path to YAML file
  */
  importYAML =
    path:
    importJSON (
      runCommand "converted.json" { nativeBuildInputs = [ pkgs.yj ]; } ''
        yj < ${path} > $out
      ''
    );

  /**
    Reads an INI file

    # Example

    ```nix
    importINI ./file.ini
    ```

    # Type

    ```
    importINI :: Path -> Any
    ```

    # Arguments

    - [path] Path to INI file
  */
  importINI =
    path:
    importJSON (
      runCommand "converted.json" { nativeBuildInputs = [ pkgs.jc ]; } ''
        jc --ini < ${path} > $out
      ''
    );

  /**
    Reads a raw INI file

    # Example

    ```nix
    importINIRaw ./file.ini
    ```

    # Type

    ```
    importINIRaw :: Path -> Any
    ```

    # Arguments

    - [path] Path to INI file
  */
  importINIRaw =
    path:
    importJSON (
      runCommand "converted.json" { nativeBuildInputs = [ pkgs.jc ]; } ''
        jc --ini -r < ${path} > $out
      ''
    );

  /**
    Creates an attribute set of standard Catppuccin module options

    # Example

    ```
    mkCatppuccinOption { name = "myProgram"; }
    ```

    # Type

    ```
    mkCatppuccinOption :: AttrSet -> AttrSet
    ```

    # Arguments

    - [name] Name of the module
    - [useGlobalEnable] Whether to enable the module by default when `catppuccin.enable` is set (recommended, defaults to `true`)
    - [default] Default `enable` option value (defaults to `if useGlobalEnable then config.catppuccin.autoEnable else false`)
    - [defaultText] Default `enable` option text (automatic if `null`, defaults to `if useGlobalEnable then "config.catppuccin.autoEnable" else null`)
    - [accentSupport] Add an `accent` option (defaults to `false`)
  */
  mkCatppuccinOption =
    {
      name,
      useGlobalEnable ? true,
      default ? if useGlobalEnable then config.catppuccin.autoEnable else false,
      defaultText ? if useGlobalEnable then "catppuccin.autoEnable" else null,
      accentSupport ? false,
    }:

    {
      enable =
        mkEnableOption "Catppuccin theme for ${name}"
        // (
          {
            inherit default;
          }
          // optionalAttrs (defaultText != null) { inherit defaultText; }
        );

      flavor = mkOption {
        type = ctp.types.flavor;
        default = config.catppuccin.flavor;
        defaultText = "catppuccin.flavor";
        description = "Catppuccin flavor for ${name}";
      };
    }
    // optionalAttrs accentSupport {
      accent = mkOption {
        type = ctp.types.accent;
        default = config.catppuccin.accent;
        defaultText = "catppuccin.accent";
        description = "Catppuccin accent for ${name}";
      };
    };

  /**
    Returns the current release version of nixos or home-manager.
    Throws an evaluation error if neither are found

    # Example

    ```nix
    getModuleRelease
    => "24.11"
    ```

    # Type

    ```
    getModuleRelease :: String
    ```
  */
  getModuleRelease =
    config.home.version.release or config.system.nixos.release
      or (throw "Couldn't determine release version!");

  /**
    Create options only if the current module release is more than a given version

    # Example

    ```nix
    mkVersionedOpts "24.11" { myOption = lib.mkOption { ... }; }
    => { myOption = { ... }; }
    ```

    # Type

    ```
    mkVersionedOpts :: String -> AttrSet -> AttrSet
    ```

    # Arguments

    - [minVersion] Minimum module release to create options for
    - [options] Conditional options
  */
  mkVersionedOpts =
    minVersion: options:
    if versionAtLeast ctp.getModuleRelease minVersion then options else mkSinkUndeclaredOptions { };

  /**
    Imports the given modules with the current library

    # Example

    ```nix
    applyToModules [ ./module.nix ]
    => [ { ... } ]
    ```

    # Type

    ```
    applyToModules :: [ Module ] -> [ Module ]
    ```

    # Arguments

    - [modules] Modules to import
    ```
  */
  applyToModules = map (flip importApply { catppuccinLib = ctp; });
})
